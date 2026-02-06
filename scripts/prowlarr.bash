# Get Arr App information
prowlarr_url="http://unlimited_prowlarr:9696"
prowlarr_api_key="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /prowlarr/config.xml)"
radarr_name="unlimited_radarr"
radarr_url="http://unlimited_radarr:7878"
radarr_api_key="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /radarr/config.xml)"
sonarr_name="unlimited_sonarr"
sonarr_url="http://unlimited_sonarr:8989"
sonarr_api_key="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /sonarr/config.xml)"

echo "Adding: $radarr_name"
addRadarrToProwlarr=$(curl -s "$prowlarr_url/api/v1/applications?" -H 'Content-Type: application/json' -H "X-Api-Key: $prowlarr_api_key" \
	--data-raw "{\"syncLevel\":\"fullSync\",\"enable\":true,\"fields\":[{\"name\":\"prowlarrUrl\",\"value\":\"$prowlarr_url\"},{\"name\":\"baseUrl\",\"value\":\"$radarr_url\"},{\"name\":\"apiKey\",\"value\":\"$radarr_api_key\"},{\"name\":\"syncCategories\",\"value\":[2000,2010,2020,2030,2040,2045,2050,2060,2070,2080,2090]},{\"name\":\"syncRejectBlocklistedTorrentHashesWhileGrabbing\",\"value\":false}],\"implementationName\":\"Radarr\",\"implementation\":\"Radarr\",\"configContract\":\"RadarrSettings\",\"infoLink\":\"https://wiki.servarr.com/prowlarr/supported#radarr\",\"tags\":[],\"name\":\"$radarr_name\"}")

echo "Adding: $sonarr_name"
addSonarrToProwlarr=$(curl -s "$prowlarr_url/api/v1/applications?" -H 'Content-Type: application/json' -H "X-Api-Key: $prowlarr_api_key" \
	--data-raw "{\"syncLevel\":\"fullSync\",\"enable\":true,\"fields\":[{\"name\":\"prowlarrUrl\",\"value\":\"$prowlarr_url\"},{\"name\":\"baseUrl\",\"value\":\"$sonarr_url\"},{\"name\":\"apiKey\",\"value\":\"$sonarr_api_key\"},{\"name\":\"syncCategories\",\"value\":[5000,5010,5020,5030,5040,5045,5050,5090]},{\"name\":\"animeSyncCategories\",\"value\":[5070]},{\"name\":\"syncAnimeStandardFormatSearch\",\"value\":true},{\"name\":\"syncRejectBlocklistedTorrentHashesWhileGrabbing\",\"value\":false}],\"implementationName\":\"Sonarr\",\"implementation\":\"Sonarr\",\"configContract\":\"SonarrSettings\",\"infoLink\":\"https://wiki.servarr.com/prowlarr/supported#sonarr\",\"tags\":[],\"name\":\"$sonarr_name\"}")

exit
