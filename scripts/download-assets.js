const https = require('https');
const http = require('http');
const fs = require('fs');
const path = require('path');

const assets = {
  // Logo
  'public/images/logo.png': 'https://activegamesworld.com/wp-content/uploads/2025/11/Logo-1.png',
  
  // Contact image
  'public/images/contact-image.png': 'https://activegamesworld.com/wp-content/uploads/2025/11/F7A9E442-7C30-4276-B3B5-225CDBF39A72-1024x683.png',
  
  // Games thumbnails
  'public/images/games/grid-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/Activate-Edit-2-1024x571-1.jpg',
  'public/images/games/arena-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/arena-activate-wall-led-game-systems-price-4.jpg',
  'public/images/games/push-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48.jpeg',
  'public/images/games/basketball-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/images-14.jpg',
  'public/images/games/climbing-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/wall-interactive-activate-game-climb.jpg',
  'public/images/games/hide-thumb.png': 'https://activegamesworld.com/wp-content/uploads/2025/11/hide-scaled.png',
  'public/images/games/flash-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48-1.jpeg',
  'public/images/games/laser-thumb.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/images-15.jpg',
  'public/images/games/control-thumb.png': 'https://activegamesworld.com/wp-content/uploads/2025/11/control-scaled.png',
  
  // Games popup images
  'public/images/games/grid-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/un-action-game-avec-des.jpg',
  'public/images/games/arena-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/arena-activate-wall-led-game-systems-price-4.jpg',
  'public/images/games/push-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48.jpeg',
  'public/images/games/basketball-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/images-14.jpg',
  'public/images/games/climbing-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/wall-interactive-activate-game-climb-1024x576.jpg',
  'public/images/games/hide-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/246180.jpg',
  'public/images/games/flash-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/WhatsApp-Image-2025-11-18-at-18.18.48-1.jpeg',
  'public/images/games/laser-popup.jpg': 'https://activegamesworld.com/wp-content/uploads/2025/11/images-15.jpg',
  'public/images/games/control-popup.png': 'https://activegamesworld.com/wp-content/uploads/2025/11/control-scaled.png',
  
  // Videos
  'public/videos/grid.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/Grille-active-games.mp4',
  'public/videos/push.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/PUSH.mp4',
  'public/videos/basketball.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/Hoops-Basketball.mp4',
  'public/videos/climbing.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/climb.mp4',
  'public/videos/hide.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/hide-1.mp4',
  'public/videos/flash.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/flash.mp4',
  'public/videos/laser.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/laser.mp4',
  'public/videos/control.mp4': 'https://activegamesworld.com/wp-content/uploads/2025/11/control.mp4',
};

function downloadFile(url, dest) {
  return new Promise((resolve, reject) => {
    const dir = path.dirname(dest);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    const file = fs.createWriteStream(dest);
    const protocol = url.startsWith('https') ? https : http;
    
    protocol.get(url, (response) => {
      if (response.statusCode === 301 || response.statusCode === 302) {
        file.close();
        fs.unlinkSync(dest);
        downloadFile(response.headers.location, dest).then(resolve).catch(reject);
      } else if (response.statusCode === 200) {
        response.pipe(file);
        file.on('finish', () => {
          file.close();
          resolve();
        });
      } else {
        file.close();
        fs.unlinkSync(dest);
        reject(new Error(`HTTP ${response.statusCode}`));
      }
    }).on('error', (err) => {
      file.close();
      if (fs.existsSync(dest)) fs.unlinkSync(dest);
      reject(err);
    });
  });
}

async function downloadAll() {
  console.log('\\n📥 TÉLÉCHARGEMENT DES ASSETS ACTIVE GAMES');
  console.log('==========================================\\n');
  
  const entries = Object.entries(assets);
  let completed = 0;
  let failed = 0;
  
  for (const [dest, url] of entries) {
    try {
      const filename = path.basename(dest);
      process.stdout.write(`[${completed + failed + 1}/${entries.length}] ${filename.padEnd(30)} `);
      await downloadFile(url, dest);
      completed++;
      console.log('✅');
    } catch (err) {
      failed++;
      console.log(`❌ ${err.message}`);
    }
  }
  
  console.log('\\n==========================================');
  console.log(`✅ Réussis: ${completed}`);
  console.log(`❌ Échecs: ${failed}`);
  console.log('==========================================\\n');
  
  if (completed > 0) {
    console.log('🚀 Prêt! Lance maintenant:');
    console.log('   npm run dev -- -p 3003\\n');
  }
}

downloadAll();
