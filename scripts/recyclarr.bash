version="1.1"
scriptName="Recyclarr"

RemoveOldConfig () {
	echo "Removing $1.yaml"
	recyclarrConfigFile="/recyclarr/configs/${1}.yaml"
	if [ -f "$recyclarrConfigFile" ]; then
		rm "$recyclarrConfigFile"
	fi
	cp /config/${1}.yaml "$recyclarrConfigFile"
} 

ApiKey () {
	
	# Get Arr App information
	arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /$1/config.xml)"

	echo "Adding API Key for recyclarr to $1"
	recyclarrConfigFile="/recyclarr/configs/${2}.yaml"
	if [ -f "$recyclarrConfigFile" ]; then
		sed -i "s%arr_api_${1}_key%$arrApiKey%g" "$recyclarrConfigFile"
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
	recyclarrConfigFile="/recyclarr/includes/${1}.yaml"
	if [ -f /config/${1}.yaml ]; then
		if [ -f "$recyclarrConfigFile" ]; then
			rm "$recyclarrConfigFile"
		fi
		cp /config/${1}.yaml "$recyclarrConfigFile"
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
ApiKey "radarr_4k" "radarr"
ApiKey "radarr_remux" "radarr"
ApiKey "radarr" "radarr"
Includes "radarr"
ApiKey "sonarr_4k" "sonarr"
ApiKey "sonarr" "sonarr"
Includes "sonarr"

exit
