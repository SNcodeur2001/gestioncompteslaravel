<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[WebReinvent](https://webreinvent.com/)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel/)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Jump24](https://jump24.co.uk)**
- **[Redberry](https://redberry.international/laravel/)**
- **[Active Logic](https://activelogic.com)**
- **[byte5](https://byte5.de)**
- **[OP.GG](https://op.gg)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

# Gestion Comptes - API Documentation

## Overview

This Laravel application provides a RESTful API for managing bank accounts (comptes) with full CRUD operations, filtering, searching, and pagination capabilities.

## API Endpoints

### Base URL
```
http://localhost:8000/api/v1
```

### Authentication
Currently, no authentication is required for API access.

---

## 📋 GET /comptes - List All Accounts

Retrieve a paginated list of all bank accounts with optional filtering, searching, and sorting.

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number for pagination |
| `limit` | integer | 10 | Number of items per page (max: 100) |
| `type` | string | - | Filter by account type: `epargne`, `cheque`, `courant` |
| `statut` | string | - | Filter by status: `actif`, `bloque`, `ferme` |
| `search` | string | - | Search by account number or client name |
| `sort` | string | `created_at` | Sort by: `dateCreation`, `solde`, `titulaire` |
| `order` | string | `desc` | Sort order: `asc` or `desc` |

### Headers
```
Accept: application/json
```

### Example Requests

#### Get all accounts (default pagination)
```bash
GET /api/v1/comptes
```

#### Get accounts with custom pagination
```bash
GET /api/v1/comptes?page=1&limit=20
```

#### Filter by account type
```bash
GET /api/v1/comptes?type=epargne
```

#### Filter by status
```bash
GET /api/v1/comptes?statut=actif
```

#### Search accounts
```bash
GET /api/v1/comptes?search=John
```

#### Sort by balance descending
```bash
GET /api/v1/comptes?sort=solde&order=desc
```

#### Combined filters
```bash
GET /api/v1/comptes?page=1&limit=10&type=epargne&statut=actif&sort=solde&order=desc&search=Doe
```

### Response Format

#### Success Response (200 OK)
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "numeroCompte": "C00123456",
      "titulaire": "Amadou Diallo",
      "type": "epargne",
      "solde": 1250000,
      "devise": "FCFA",
      "dateCreation": "2023-03-15T00:00:00Z",
      "statut": "bloque",
      "motifBlocage": "Inactivité de 30+ jours",
      "metadata": {
        "derniereModification": "2023-06-10T14:30:00Z",
        "version": 1
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 3,
    "totalItems": 25,
    "itemsPerPage": 10,
    "hasNext": true,
    "hasPrevious": false
  },
  "links": {
    "self": "/api/v1/comptes?page=1&limit=10",
    "next": "/api/v1/comptes?page=2&limit=10",
    "first": "/api/v1/comptes?page=1&limit=10",
    "last": "/api/v1/comptes?page=3&limit=10"
  }
}
```

### Response Fields

#### Account Object
- `id`: UUID of the account
- `numeroCompte`: Account number (string)
- `titulaire`: Account holder name (string)
- `type`: Account type (`epargne`, `cheque`, `courant`)
- `solde`: Account balance (decimal)
- `devise`: Currency (`FCFA`)
- `dateCreation`: Creation date (ISO 8601)
- `statut`: Account status (`actif`, `bloque`, `ferme`)
- `motifBlocage`: Block reason (string, nullable)
- `metadata`: Additional metadata object
  - `derniereModification`: Last modification date (ISO 8601)
  - `version`: API version (integer)

#### Pagination Object
- `currentPage`: Current page number
- `totalPages`: Total number of pages
- `totalItems`: Total number of accounts
- `itemsPerPage`: Items per page
- `hasNext`: Boolean indicating if there's a next page
- `hasPrevious`: Boolean indicating if there's a previous page

#### Links Object
- `self`: Current page URL
- `next`: Next page URL (if available)
- `first`: First page URL
- `last`: Last page URL

### Error Responses

#### 400 Bad Request
```json
{
  "success": false,
  "message": "Invalid parameters",
  "errors": {
    "type": ["The type must be one of: epargne, cheque, courant"],
    "limit": ["The limit may not be greater than 100"]
  }
}
```

#### 404 Not Found
```json
{
  "success": false,
  "message": "No accounts found"
}
```

#### 500 Internal Server Error
```json
{
  "success": false,
  "message": "Internal server error"
}
```

### Notes

- All dates are returned in ISO 8601 format (UTC)
- Account balances are returned as decimal numbers
- Pagination links include all current query parameters
- Search is case-insensitive and searches both account numbers and client names
- The API supports CORS for cross-origin requests

---

## 📝 POST /comptes - Create New Account

Create a new bank account with client information. If the client doesn't exist, it will be created automatically along with a user account.

### Headers
```
Accept: application/json
Content-Type: application/json
```

### Request Body

#### Create account for new client
```json
{
  "type": "cheque",
  "soldeInitial": 50000,
  "devise": "FCFA",
  "solde": 10000,
  "client": {
    "titulaire": "Hawa BB Wane",
    "nci": "1987654321098",
    "email": "cheikh.sy@example.com",
    "telephone": "+221771234567",
    "adresse": "Dakar, Sénégal"
  }
}
```

#### Create account for existing client
```json
{
  "type": "epargne",
  "soldeInitial": 25000,
  "devise": "FCFA",
  "solde": 25000,
  "client": {
    "id": "uuid-of-existing-client"
  }
}
```

### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | string | Yes | Account type: `cheque`, `courant`, `epargne` |
| `soldeInitial` | number | Yes | Initial balance (minimum: 10,000 FCFA) |
| `devise` | string | Yes | Currency: `FCFA`, `XOF`, `USD`, `EUR` |
| `solde` | number | Yes | Current balance (minimum: 0) |
| `client.id` | string | No* | UUID of existing client (*required if creating account for existing client) |
| `client.titulaire` | string | No* | Client name (*required if client.id not provided) |
| `client.nci` | string | No* | Senegalese ID number (*required if client.id not provided) |
| `client.email` | string | No* | Email address (*required if client.id not provided) |
| `client.telephone` | string | No* | Phone number (*required if client.id not provided) |
| `client.adresse` | string | No* | Address (*required if client.id not provided) |

### Validation Rules

- **NCI**: Must be 13 digits starting with 1 or 2 (Senegalese format)
- **Telephone**: Must be in format +221XXXXXXXXX (9 digits after +221)
- **Email**: Must be unique across all clients
- **Telephone**: Must be unique across all clients
- **NCI**: Must be unique across all clients
- **soldeInitial**: Must be ≥ 10,000 FCFA

### Success Response (201 Created)
```json
{
  "success": true,
  "message": "Compte créé avec succès",
  "data": {
    "id": "uuid",
    "numeroCompte": "COMP-123456",
    "titulaire": "Hawa BB Wane",
    "type": "cheque",
    "solde": 10000,
    "devise": "FCFA",
    "dateCreation": "2023-03-15T00:00:00Z",
    "statut": "actif",
    "motifBlocage": null,
    "metadata": {
      "derniereModification": "2023-03-15T00:00:00Z",
      "version": 1
    }
  }
}
```

### Error Response (400 Bad Request)
```json
{
  "success": false,
  "message": "Les données fournies sont invalides",
  "errors": {
    "code": "VALIDATION_ERROR",
    "message": "Les données fournies sont invalides",
    "details": {
      "client.nci": ["Ce numéro de carte d'identité est déjà utilisé."],
      "client.email": ["Cette adresse email est déjà utilisée."],
      "soldeInitial": ["Le solde initial doit être d'au moins 10 000 FCFA."]
    }
  }
}
```

### Business Logic

1. **Client Verification**: Check if client exists by ID or create new client
2. **User Creation**: For new clients, create user account with generated password
3. **Account Creation**: Generate unique account number and create account
4. **Notifications**:
   - Send welcome email with generated password
   - Send SMS with verification code
5. **Response**: Return formatted account data

### Notes

- Account numbers are auto-generated in format `COMP-XXXXXX`
- New clients receive auto-generated passwords and verification codes
- Email and SMS sending are currently logged (placeholders for production implementation)
- All monetary values are stored as decimals
- Client data validation follows Senegalese standards

---

## 🔍 GET /comptes/{compteId} - Get Specific Account

Retrieve a single bank account by its UUID.

### Headers
```
Accept: application/json
```

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `compteId` | string | Yes | UUID of the account to retrieve |

### Example Request
```bash
GET /api/v1/comptes/550e8400-e29b-41d4-a716-446655440000
```

### Success Response (200 OK)
```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "numeroCompte": "C00123456",
    "titulaire": "Amadou Diallo",
    "type": "epargne",
    "solde": 1250000,
    "devise": "FCFA",
    "dateCreation": "2023-03-15T00:00:00Z",
    "statut": "bloque",
    "motifBlocage": "Inactivité de 30+ jours",
    "metadata": {
      "derniereModification": "2023-06-10T14:30:00Z",
      "version": 1
    }
  }
}
```

### Error Response (404 Not Found)
```json
{
  "success": false,
  "error": {
    "code": "COMPTE_NOT_FOUND",
    "message": "Le compte avec l'ID spécifié n'existe pas",
    "details": {
      "compteId": "550e8400-e29b-41d4-a716-446655440000"
    }
  }
}
```

### Notes

- Returns complete account information including client details
- Uses Laravel route model binding for automatic UUID resolution
- Proper error handling with structured error responses
- All data formatted according to the API specification

---

## Database Schema

### comptes table
- `id`: UUID (primary key)
- `client_id`: UUID (foreign key to clients table)
- `numero`: Account number (string, unique)
- `type`: Account type (enum: epargne, cheque, courant)
- `soldeInitial`: Initial balance (decimal)
- `solde`: Current balance (decimal)
- `devise`: Currency (string, default: FCFA)
- `statut`: Status (enum: actif, bloque, ferme, default: actif)
- `motifBlocage`: Block reason (text, nullable)
- `created_at`: Creation timestamp
- `updated_at`: Update timestamp

### clients table
- `id`: UUID (primary key)
- `titulaire`: Client name (string)
- `nci`: National ID (string, unique)
- `email`: Email address (string, unique)
- `telephone`: Phone number (string)
- `adresse`: Address (text)
- `created_at`: Creation timestamp
- `updated_at`: Update timestamp

---

## Testing with Postman

### Collection Setup
1. Create a new collection: "Gestion Comptes API"
2. Add a new request: "List Accounts"
3. Set method to: `GET`
4. Set URL to: `http://localhost:8000/api/v1/comptes`
5. Add header: `Accept: application/json`

### Sample Test Cases

1. **Basic listing**: `GET /api/v1/comptes`
2. **Pagination**: `GET /api/v1/comptes?page=2&limit=5`
3. **Filtering**: `GET /api/v1/comptes?type=epargne&statut=actif`
4. **Searching**: `GET /api/v1/comptes?search=John`
5. **Sorting**: `GET /api/v1/comptes?sort=solde&order=desc`
6. **Combined**: `GET /api/v1/comptes?page=1&limit=10&type=epargne&sort=solde&order=desc&search=Doe`

---

## Development Notes

- Laravel 10 framework
- PostgreSQL database
- UUID primary keys
- Eloquent ORM with relationships
- API Resource for response formatting
- Custom exception handling
- CORS enabled for api/* routes
- Pagination with custom metadata
- Comprehensive filtering and searching
- Flexible sorting options

# gestioncompteslaravel
