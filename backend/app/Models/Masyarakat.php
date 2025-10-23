<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Masyarakat extends Model
{
    use HasFactory;

    // nama tabel di database
    protected $table = 'masyarakats'; // pakai bentuk jamak

    protected $fillable = [
        'nama',
        'email',
        'password',
    ];
}
