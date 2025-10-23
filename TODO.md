# TODO - US 2.0: Lister tous les comptes

## Completed Tasks
- [x] Ajouter soft deletes à la table comptes
- [x] Migrer la base de données pour soft deletes
- [x] Ajouter le trait SoftDeletes au modèle Compte
- [x] Créer un scope global pour récupérer les comptes non supprimés
- [x] Créer un scope local scopeNumero pour récupérer un compte par son numéro
- [x] Créer un scope local scopeClient pour récupérer les comptes d'un client basé sur le téléphone
- [x] Créer le middleware RatingMiddleware pour enregistrer les utilisateurs atteignant le rating limit
- [x] Enregistrer le middleware RatingMiddleware dans le Kernel
- [x] Modifier les routes pour utiliser l'authentification et le middleware rating
- [x] Modifier le contrôleur CompteController pour différencier admin et client
- [x] Ajouter la colonne archived à la table comptes
- [x] Migrer la base de données pour la colonne archived
- [x] Modifier le scope global pour exclure les comptes archivés
- [x] Créer CompteArchiveController pour gérer les comptes archivés
- [x] Ajouter les routes pour les comptes archivés
- [x] Vérifier les routes avec artisan route:list

## Remaining Tasks
- [x] Tester l'endpoint GET /api/v1/comptes pour admin
- [x] Tester l'endpoint GET /api/v1/comptes pour client
- [ ] Tester l'endpoint GET /api/v1/comptes/archives
- [x] Vérifier la pagination et les filtres
- [x] Vérifier la réponse JSON correspond au format spécifié
- [ ] Documenter les routes (Swagger/OpenAPI)
- [ ] Tester les exceptions personnalisées
- [ ] Vérifier la configuration CORS
