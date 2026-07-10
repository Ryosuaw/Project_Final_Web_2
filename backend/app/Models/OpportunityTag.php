<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OpportunityTag extends Model
{
    protected $fillable = ['opportunity_id', 'tag'];

    public function opportunity()
    {
        return $this->belongsTo(Opportunity::class);
    }
}