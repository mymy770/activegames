#!/bin/bash

# Script pour télécharger tous les assets du site Active Games
# Exécuter avec: chmod +x download-assets.sh && ./download-assets.sh

echo "📥 Téléchargement des assets Active Games..."

# Créer les dossiers
mkdir -p public/images/games
mkdir -p public/videos

# Logo
echo "Téléchargement du logo..."
curl -o public/images/logo.png "https://activegamesworld.com/wp-content/uploads/2025/11/Logo-1.png"

# Image de contact
echo "Téléchargement de l'image contact..."
curl -o public/images/contact-image.png "https://activegamesworld.com/wp-content/uploads/2025/11/F7A9E442-7C30-4276-B3B5-225CDBF39A72-1024x683.png"

# Games - Thumbnails
echo "Téléchargement des thumbnails des jeux..."
curl -o public/images/games/grid-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/Activate-Edit-2-1024x571-1.jpg"
curl -o public/images/games/arena-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/arena-activate-wall-led-game-systems-price-4.jpg"
curl -o public/images/games/push-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48.jpeg"
curl -o public/images/games/basketball-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/images-14.jpg"
curl -o public/images/games/climbing-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/wall-interactive-activate-game-climb.jpg"
curl -o public/images/games/hide-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/hide-scaled.png"
curl -o public/images/games/flash-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48-1.jpeg"
curl -o public/images/games/laser-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/images-15.jpg"
curl -o public/images/games/control-thumb.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/control-scaled.png"

# Games - Popup images
echo "Téléchargement des images popup..."
curl -o public/images/games/grid-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/un-action-game-avec-des.jpg"
curl -o public/images/games/arena-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/arena-activate-wall-led-game-systems-price-4.jpg"
curl -o public/images/games/push-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48.jpeg"
curl -o public/images/games/basketball-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/images-14.jpg"
curl -o public/images/games/climbing-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/wall-interactive-activate-game-climb-1024x576.jpg"
curl -o public/images/games/hide-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/246180.jpg"
curl -o public/images/games/flash-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48-1.jpeg"
curl -o public/images/games/laser-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/images-15.jpg"
curl -o public/images/games/control-popup.jpg "https://activegamesworld.com/wp-content/uploads/2025/11/control-scaled.png"

# Videos
echo "Téléchargement des vidéos (cela peut prendre du temps)..."
curl -o public/videos/grid.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/Grille-active-games.mp4"
curl -o public/videos/arena.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/Video-sans-titre-‐-Realisee-avec-Clipchamp-2.mp4"
curl -o public/videos/push.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/PUSH.mp4"
curl -o public/videos/basketball.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/Hoops-Basketball.mp4"
curl -o public/videos/climbing.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/climb.mp4"
curl -o public/videos/hide.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/hide-1.mp4"
curl -o public/videos/flash.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/flash.mp4"
curl -o public/videos/laser.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/laser.mp4"
curl -o public/videos/control.mp4 "https://activegamesworld.com/wp-content/uploads/2025/11/control.mp4"

echo "✅ Téléchargement terminé!"
echo ""
echo "Prochaines étapes:"
echo "1. npm install"
echo "2. npm run dev"
