<?php

namespace App\Services;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class ImageService
{
    /**
     * Store an uploaded image in the public storage and return its URL.
     *
     * @param UploadedFile $image
     * @param string $folder
     * @return string
     */
    public static function storeImage(UploadedFile $image, string $folder = 'images')
    {
        $path = $image->store($folder, 'public');
        return '/storage/' . $path;
    }
}
