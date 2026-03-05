version="1.3"
scriptName="Recyclarr"
Process () {

	
	# Get Arr App information
	arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /$1/config.xml)"

	echo "Configuring recyclarr for $1"
	recyclarrConfigFile="/recyclarr/configs/${2}.yaml"
	if [ -f "$recyclarrConfigFile" ]; then
		rm "$recyclarrConfigFile"
	fi
	cp /config/$folder.yaml "$recyclarrConfigFile"
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
	recyclarrConfigFile="/recyclarr/includes/${folder}_quality.yaml"
	if [ -f /config/${folder}_quality.yaml ]; then
		if [ -f "$recyclarrConfigFile" ]; then
			rm "$recyclarrConfigFile"
		fi
		cp /config/${folder}_quality.yaml "$recyclarrConfigFile"
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
Process "radarr-4k" "radarr"
Process "radarr" "radarr"
Includes "radarr"
Process "sonarr" "sonarr"
Includes "Sonarr"



exit
