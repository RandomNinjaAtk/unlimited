# Get Arr App information
arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /radarr/config.xml)"

echo "Configure Root Folder"
curl -s 'http://unlimited_radarr:7878/api/v3/rootFolder' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"path":"/mnt/user/appdata/unlimited/data/media/radarr/"}'
  

echo "Configure Settings"
curl -s 'http://unlimited_radarr:7878/api/v3/config/mediamanagement' \
  -X 'PUT' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"autoUnmonitorPreviouslyDownloadedMovies":false,"recycleBin":"","recycleBinCleanupDays":7,"downloadPropersAndRepacks":"doNotPrefer","createEmptyMovieFolders":false,"deleteEmptyFolders":false,"fileDate":"none","rescanAfterRefresh":"always","autoRenameFolders":false,"pathsDefaultStatic":false,"setPermissionsLinux":false,"chmodFolder":"755","chownGroup":"","skipFreeSpaceCheckWhenImporting":true,"minimumFreeSpaceWhenImporting":1000,"copyUsingHardlinks":true,"useScriptImport":false,"scriptImportPath":"","importExtraFiles":false,"extraFileExtensions":"srt","enableMediaInfo":false,"id":1}'

echo "Configure Metadata"
curl 'http://unlimited_radarr:7878/api/v3/metadata/1?' \
  -X 'PUT' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"enable":true,"name":"Kodi (XBMC) / Emby","fields":[{"name":"movieMetadata","value":true},{"name":"useMovieNfo","value":true},{"name":"movieMetadataLanguage","value":1},{"name":"movieMetadataURL","value":false},{"name":"addCollectionName","value":true},{"name":"movieImages","value":true}],"implementationName":"Kodi (XBMC) / Emby","implementation":"XbmcMetadata","configContract":"XbmcMetadataSettings","infoLink":"https://wiki.servarr.com/radarr/supported#xbmcmetadata","tags":[],"id":1}' 

exit
