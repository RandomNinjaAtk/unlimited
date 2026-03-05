version="1.6"
scriptName="Recyclarr"

RemoveOldConfig () {
	echo "Removing $1.yaml"
	recyclarrConfigFile="/recyclarr/configs/${1}.yaml"
	if [ -f "$recyclarrConfigFile" ]; then
		rm "$recyclarrConfigFile"
	fi
} 

ApiKey () {
	
	# Get Arr App information
	arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /$1/config.xml)"

	echo "Adding API Key for recyclarr to $1"
	cp /config/${2}.yaml "$recyclarrConfigFile"
	if [ -f "$recyclarrConfigFile" ]; then
		sed -i "s%arr_api_key_${1}%$arrApiKey%g" "$recyclarrConfigFile"
	fi
	chmod 777 "$recyclarrConfigFile"
}


Includes () {
	echo "Importing $1 include files"
	recyclarrConfigFile="/recyclarr/includes/${1}_custom_formats.yaml"
	if [ -f /config/${1}_custom_formats.yaml ]; then
		if [ -f "$recyclarrConfigFile" ]; then
			rm "$recyclarrConfigFile"
		fi
		cp /config/${1}_custom_formats.yaml "$recyclarrConfigFile"
	fi
	recyclarrConfigFile="/recyclarr/includes/${1}_quality.yaml"
	if [ -f /config/${1}_quality.yaml ]; then
		if [ -f "$recyclarrConfigFile" ]; then
			rm "$recyclarrConfigFile"
		fi
		cp /config/${1}_quality.yaml "$recyclarrConfigFile"
	fi
}

if [ ! -d /recyclarr/configs ]; then
	mkdir -p /recyclarr/configs
	chmod 777 /recyclarr/configs
fi

if [ ! -d /recyclarr/includes ]; then
	mkdir -p /recyclarr/includes
	chmod 777 /recyclarr/includes
fi

echo ""
echo "$version :: $scriptName"
RemoveOldConfig "radarr"
RemoveOldConfig "sonarr"
ApiKey "radarr-4k" "radarr"
ApiKey "radarr" "radarr"
Includes "radarr"
ApiKey "sonarr" "sonarr"
Includes "Sonarr"



exit
