<?php

$privateKeyPath = 'storage/oauth-private.key';
$publicKeyPath  = 'storage/oauth-public.key';

if (!file_exists($privateKeyPath) || !file_exists($publicKeyPath)) {
    exit("❌ Fichiers de clés introuvables. Exécute d'abord : php artisan passport:keys\n");
}

// Lire les fichiers en entier sans modification
$private = file_get_contents($privateKeyPath);
$public  = file_get_contents($publicKeyPath);

// Échapper correctement les sauts de ligne et guillemets
$private_env = addcslashes(trim($private), "\n\r\"");
$public_env  = addcslashes(trim($public), "\n\r\"");

echo "✅ Copie ces lignes dans ton fichier .env :\n\n";
echo "PASSPORT_PRIVATE_KEY=\"{$private_env}\"\n";
echo "PASSPORT_PUBLIC_KEY=\"{$public_env}\"\n";
