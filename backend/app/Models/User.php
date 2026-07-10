<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    public function studyClubs()
{
    return $this->belongsToMany(StudyClub::class, 'study_club_members')
        ->withPivot('joined_at')
        ->withTimestamps();
}
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'university',
        'major',
        'profile_photo',
        'bio',
        'is_verified',
        'profile_completion',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'is_verified' => 'boolean',
        ];
    }
    public function userSkills()
{
    return $this->hasMany(UserSkill::class);
}

public function sentRequests()
{
    return $this->hasMany(PartnerRequest::class, 'sender_id');
}

public function receivedRequests()
{
    return $this->hasMany(PartnerRequest::class, 'receiver_id');
}
public function savedOpportunities()
{
    return $this->hasMany(SavedOpportunity::class);
}
}
