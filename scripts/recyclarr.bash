Process () {

	folder="$1"
	
	# Get Arr App information
	arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /$folder/config.xml)"

	echo "Configuring recyclarr for $1"
	recyclarrConfigFile="/recyclarr/configs/${folder}.yaml"
	if [ -f "$recyclarrConfigFile" ]; then
		rm "$recyclarrConfigFile"
	fi
	cp /config/$folder.yaml "$recyclarrConfigFile"
	if [ -f "$recyclarrConfigFile" ]; then
		sed -i "s%arr_api_key%$arrApiKey%g" "$recyclarrConfigFile"
	fi
	chmod 777 "$recyclarrConfigFile"
}

if [ ! -d /recyclarr/configs ]; then
	mkdir -p /recyclarr/configs
	chmod 777 /recyclarr/configs
fi

Process "radarr"
Process "sonarr"



exit
