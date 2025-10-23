<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Client extends Model
{
    use HasFactory;

    protected $keyType = 'string';  // UUID
    public $incrementing = false;   // Pas d'auto-increment

    protected $fillable = [
        'titulaire',
        'nci',
        'email',
        'telephone',
        'adresse'
    ];

    // Générer automatiquement UUID à la création
    protected static function boot(): void
    {
        parent::boot();
        static::creating(function ($model) {
            if (empty($model->id)) {
                $model->id = (string) Str::uuid();
            }
        });
    }

    public function comptes()
    {
        return $this->hasMany(Compte::class);
    }

    /**
     * Get the route key for the model.
     */
    public function getRouteKeyName(): string
    {
        return 'id'; // Already using 'id' which is UUID
    }
}
