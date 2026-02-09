# Get Arr App information
arrApiKey="$(sed -n '/<ApiKey>/{s/.*<ApiKey>//;s/<\/ApiKey.*//;p;}' /sonarr/config.xml)"

echo "Configure Root Folder"
curl -s 'http://unlimited_sonarr:8989/api/v3/rootFolder' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"path":"/mnt/user/appdata/unlimited/data/media/sonarr/"}'
  

echo "Configure Settings"
curl -s 'http://unlimited_sonarr:8989/api/v3/config/mediamanagement' \
  -X 'PUT' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"autoUnmonitorPreviouslyDownloadedMovies":false,"recycleBin":"","recycleBinCleanupDays":7,"downloadPropersAndRepacks":"doNotPrefer","createEmptyMovieFolders":false,"deleteEmptyFolders":false,"fileDate":"none","rescanAfterRefresh":"always","autoRenameFolders":false,"pathsDefaultStatic":false,"setPermissionsLinux":false,"chmodFolder":"755","chownGroup":"","skipFreeSpaceCheckWhenImporting":true,"minimumFreeSpaceWhenImporting":1000,"copyUsingHardlinks":true,"useScriptImport":false,"scriptImportPath":"","importExtraFiles":false,"extraFileExtensions":"srt","enableMediaInfo":false,"id":1}'

echo "Configure Metadata"
curl 'http://unlimited_sonarr:8989/api/v3/metadata/4?' \
  -X 'PUT' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"enable":true,"name":"Plex","fields":[{"name":"seriesPlexMatchFile","value":true},{"name":"episodeMappings","value":true}],"implementationName":"Plex","implementation":"PlexMetadata","configContract":"PlexMetadataSettings","infoLink":"https://wiki.servarr.com/sonarr/supported#plexmetadata","tags":[],"id":4}'
  
  
curl 'http://unlimited_sonarr:8989/api/v3/metadata/1?' \
  -X 'PUT' \
  -H 'Content-Type: application/json' \
  -H "X-Api-Key: $arrApiKey" \
  --data-raw '{"enable":true,"name":"Kodi (XBMC) / Emby","fields":[{"name":"seriesMetadata","value":true},{"name":"seriesMetadataEpisodeGuide","value":false},{"name":"seriesMetadataUrl","value":false},{"name":"episodeMetadata","value":true},{"name":"episodeImageThumb","value":true},{"name":"seriesImages","value":true},{"name":"seasonImages","value":true},{"name":"episodeImages","value":true}],"implementationName":"Kodi (XBMC) / Emby","implementation":"XbmcMetadata","configContract":"XbmcMetadataSettings","infoLink":"https://wiki.servarr.com/sonarr/supported#xbmcmetadata","tags":[],"id":1}'
  
exit
