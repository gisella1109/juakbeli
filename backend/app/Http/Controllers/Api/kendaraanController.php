<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Masyarakat; // ⬅️ HURUF M BESAR
use Illuminate\Http\Request;

class kendaraanController extends Controller
{
    public function index()
    {
        return Masyarakat::all(); // ⬅️ HURUF M BESAR
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nama' => 'required|string',
            'alamat' => 'required|string',
            'email' => 'required|string|unique:masyarakats',
        ]);

        return Masyarakat::create($data); // ⬅️ HURUF M BESAR
    }

    public function show($id)
    {
        return Masyarakat::findOrFail($id); // ⬅️ HURUF M BESAR
    }

    public function update(Request $request, $id)
    {
        $data = Masyarakat::findOrFail($id); // ⬅️ HURUF M BESAR
        $data->update($request->all());
        return $data;
    }

    public function destroy($id)
    {
        $data = Masyarakat::findOrFail($id); // ⬅️ HURUF M BESAR
        $data->delete();
        return response()->noContent();
    }
}
