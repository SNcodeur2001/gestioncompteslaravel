<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Compte extends Model
{
    use HasFactory, SoftDeletes;

    protected $keyType = 'string';
    public $incrementing = false;
    protected $fillable = ['numero', 'type', 'soldeInitial', 'solde', 'devise', 'client_id', 'statut', 'motifBlocage', 'archived'];

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

    /**
     * Relation avec les transactions
     */
    public function transactions()
    {
        return $this->hasMany(Transaction::class);
    }

    /**
     * Scope global pour récupérer les comptes non supprimés et non archivés
     */
    protected static function booted(): void
    {
        static::addGlobalScope('nonSupprimes', function ($builder) {
            $builder->whereNull('deleted_at')->where('archived', false);
        });
    }

    /**
     * Scope local pour récupérer un compte par son numéro
     */
    public function scopeNumero($query, $numero)
    {
        return $query->where('numero', $numero);
    }

    /**
     * Scope local pour récupérer les comptes d'un client basé sur le téléphone
     */
    public function scopeClient($query, $telephone)
    {
        return $query->whereHas('client', function ($q) use ($telephone) {
            $q->where('telephone', $telephone);
        });
    }

    /**
     * Scope local pour récupérer les comptes actifs
     */
    public function scopeActifs($query)
    {
        return $query->where('statut', 'actif');
    }
}
