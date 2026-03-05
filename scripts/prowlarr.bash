# Get Arr App information
prowlarr_url="http://unlimited_prowlarr:9696"
prowlarr_api_key="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /prowlarr/config.xml)"
arr_name="unlimited_${1}"
arr_url="http://unlimited_${1}"
api_key="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /${1}/config.xml)"


if [ "$2" = "radarr" ]; then
	echo "Adding: ${1}"
	addRadarrToProwlarr=$(curl -s "$prowlarr_url/api/v1/applications?" -H 'Content-Type: application/json' -H "X-Api-Key: $prowlarr_api_key" \
		--data-raw "{\"syncLevel\":\"fullSync\",\"enable\":true,\"fields\":[{\"name\":\"prowlarrUrl\",\"value\":\"$prowlarr_url\"},{\"name\":\"baseUrl\",\"value\":\"${arr_url}:7878\"},{\"name\":\"apiKey\",\"value\":\"$api_key\"},{\"name\":\"syncCategories\",\"value\":[2000,2010,2020,2030,2040,2045,2050,2060,2070,2080,2090]},{\"name\":\"syncRejectBlocklistedTorrentHashesWhileGrabbing\",\"value\":false}],\"implementationName\":\"Radarr\",\"implementation\":\"Radarr\",\"configContract\":\"RadarrSettings\",\"infoLink\":\"https://wiki.servarr.com/prowlarr/supported#radarr\",\"tags\":[],\"name\":\"${arr_name}\"}")
fi

if [ "$2" = "sonarr" ]; then
	echo "Adding: ${1}"
	addSonarrToProwlarr=$(curl -s "$prowlarr_url/api/v1/applications?" -H 'Content-Type: application/json' -H "X-Api-Key: $prowlarr_api_key" \
		--data-raw "{\"syncLevel\":\"fullSync\",\"enable\":true,\"fields\":[{\"name\":\"prowlarrUrl\",\"value\":\"$prowlarr_url\"},{\"name\":\"baseUrl\",\"value\":\"${arr_url}:8989\"},{\"name\":\"apiKey\",\"value\":\"$api_key\"},{\"name\":\"syncCategories\",\"value\":[5000,5010,5020,5030,5040,5045,5050,5090]},{\"name\":\"animeSyncCategories\",\"value\":[5070]},{\"name\":\"syncAnimeStandardFormatSearch\",\"value\":true},{\"name\":\"syncRejectBlocklistedTorrentHashesWhileGrabbing\",\"value\":false}],\"implementationName\":\"Sonarr\",\"implementation\":\"Sonarr\",\"configContract\":\"SonarrSettings\",\"infoLink\":\"https://wiki.servarr.com/prowlarr/supported#sonarr\",\"tags\":[],\"name\":\"${arr_name}\"}")
fi

exit
