<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StudyClub extends Model
{
    protected $fillable = ['name', 'description', 'created_by'];

    /**
     * User yang membuat grup ini
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * Semua anggota grup (many-to-many lewat study_club_members)
     */
    public function members()
    {
        return $this->belongsToMany(User::class, 'study_club_members')
            ->withPivot('joined_at')
            ->withTimestamps();
    }
}
