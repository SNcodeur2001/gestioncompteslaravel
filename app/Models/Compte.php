<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Compte extends Model
{
    use HasFactory;

    protected $keyType = 'string';
    public $incrementing = false;
    protected $fillable = ['numero', 'type', 'soldeInitial', 'solde', 'devise', 'client_id', 'statut', 'motifBlocage'];

    protected static function boot(): void
    {
        parent::boot();
        static::creating(function ($model) {
            $model->id = (string) Str::uuid();
        });
    }

    public function setNumeroAttribute($value)
    {
        $this->attributes['numero'] = $value ?? 'COMP-' . mt_rand(100000, 999999);
    }

    public function client()
    {
        return $this->belongsTo(Client::class);
    }
}
