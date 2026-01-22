// Upload du backup complet (structure) vers Supabase Storage
// À exécuter UNE SEULE FOIS

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Configuration depuis .env.local
const SUPABASE_URL = 'https://zapwlcrjnabrfhoxfgqo.supabase.co';
const SUPABASE_SERVICE_KEY = 'sb_secret_G1LaEDDOvFm8_ASVRousRA_05co6r_O';

const BACKUP_FILE = path.join(__dirname, '../backups/backup_20260122_134232.sql');

async function uploadSchemaBackup() {
  console.log('🚀 Upload du backup complet vers Supabase Storage...');

  // Créer le client Supabase
  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

  // Lire le fichier SQL
  const sqlContent = fs.readFileSync(BACKUP_FILE);
  const fileSize = (sqlContent.length / 1024).toFixed(2);

  console.log(`📦 Fichier: ${path.basename(BACKUP_FILE)}`);
  console.log(`📊 Taille: ${fileSize} KB`);

  // Upload dans le bucket 'backups'
  const filename = `schema_complete_${new Date().toISOString().split('T')[0]}.sql`;

  const { data, error } = await supabase
    .storage
    .from('backups')
    .upload(filename, sqlContent, {
      contentType: 'application/sql',
      upsert: false
    });

  if (error) {
    console.error('❌ Erreur upload:', error.message);
    process.exit(1);
  }

  console.log(`✅ Upload réussi: ${filename}`);
  console.log(`\n📍 Fichier disponible dans:`);
  console.log(`   Supabase Dashboard → Storage → backups → ${filename}`);
}

uploadSchemaBackup();
