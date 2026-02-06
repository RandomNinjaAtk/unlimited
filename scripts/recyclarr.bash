getArrAppInfo () {
  # Get Arr App information
  if [ -z "$arrUrl" ] || [ -z "$arrApiKey" ]; then
	arrUrlBase="$(sed -n '/<UrlBase>/{s/.*<UrlBase>//;s/<\/UrlBase.*//;p;}' /radarr/config.xml)"
    if [ "$arrUrlBase" == "null" ]; then
      arrUrlBase=""
    else
      arrUrlBase="/$(echo "$arrUrlBase" | sed "s/\///")"
    fi
	arrName="$(sed -n '/<InstanceName>/{s/.*<InstanceName>//;s/<\/InstanceName.*//;p;}' /radarr/config.xml)"
	arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /radarr/config.xml)"
	arrPort="$(sed -n '/<Port>/{s/.*<Port>//;s/<\/Port.*//;p;}' /radarr/config.xml)"
    arrUrl="http://127.0.0.1:${arrPort}${arrUrlBase}"
  fi
}

Process () {

	folder="$1"
	getArrAppInfo

	echo "Configuring recyclarr for $arrName"
	recyclarrConfigFile="/recyclarr/configs/${arrName}.yaml"
	if [ -f "$recyclarrConfigFile" ]; then
		rm "$recyclarrConfigFile"
	fi
	cp /git-sync/configs/recyclarr/radarr.yaml "$recyclarrConfigFile"
	if [ -f "$recyclarrConfigFile" ]; then
		sed -i "s%instance_name%$arrName%g" "$recyclarrConfigFile"
		sed -i "s%enter_url%$arrUrl%g" "$recyclarrConfigFile"
		sed -i "s%enter_api_key%$arrApiKey%g" "$recyclarrConfigFile"
	fi
}

Process "/radarr"



exit
