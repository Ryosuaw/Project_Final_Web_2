<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Opportunity extends Model
{
    protected $fillable = ['type', 'title', 'organizer', 'description', 'deadline', 'benefit', 'is_online'];

    public function tags()
    {
        return $this->hasMany(OpportunityTag::class);
    }

    public function savedBy()
    {
        return $this->hasMany(SavedOpportunity::class);
    }
}