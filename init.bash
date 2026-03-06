echo "Downloading Scripts"
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/prowlarr.bash" -o /config/prowlarr.bash
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/radarr.bash" -o /config/radarr.bash
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/sonarr.bash" -o /config/sonarr.bash
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/recyclarr.bash" -o /config/recyclarr.bash

echo "Downloading Configs"
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/radarr.yaml" -o /config/radarr.yaml
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/includes/radarr_custom_formats.yaml" -o /config/radarr_custom_formats.yaml
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/includes/radarr_quality.yaml" -o /config/radarr_quality.yaml
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/sonarr.yaml" -o /config/sonarr.yaml
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/includes/sonarr_custom_formats.yaml" -o /config/sonarr_custom_formats.yaml
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/includes/sonarr_quality.yaml" -o /config/sonarr_quality.yaml

echo "Setting Permissions:"
chmod 777 -R /config/*

echo "Exectuing Scripts"
bash /config/prowlarr.bash "radarr" "radarr"
bash /config/prowlarr.bash "radarr_4k" "radarr"
bash /config/prowlarr.bash "radarr_remux" "radarr"
bash /config/prowlarr.bash "sonarr" "sonarr"
bash /config/prowlarr.bash "sonarr_4k" "sonarr"
bash /config/radarr.bash "radarr"
bash /config/radarr.bash "radarr_4k"
bash /config/sonarr.bash "sonarr"
bash /config/sonarr.bash "sonarr_4k"
bash /config/recyclarr.bash
exit
