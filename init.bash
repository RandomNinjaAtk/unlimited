echo "Downloading Scripts"
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/prowlarr.bash" -o /config/prowlarr.bash
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/radarr.bash" -o /config/radarr.bash
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/scripts/recyclarr.bash" -o /config/recyclarr.bash

echo "Downloading Configs"
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/radarr.yaml" -o /config/radarr.yaml
curl "https://raw.githubusercontent.com/RandomNinjaAtk/unlimited/refs/heads/main/configs/recyclarr/sonarr.yaml" -o /config/sonarr.yaml

echo "Setting Permissions:"
chmod 777 -R /config/*

echo "Exectuing Scripts"
bash /config/prowlarr.bash
bash /config/radarr.bash
bash /config/recyclarr.bash
exit
