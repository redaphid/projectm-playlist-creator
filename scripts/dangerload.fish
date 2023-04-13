#!/usr/bin/env fish
function get_playlist --argument playlist
  set -q playlist[1]; or set playlist $PLAYLIST
  set -q playlist[1]; or set playlist "default"
  echo $playlist
end
function select --argument playlist
  set playlist (get_playlist $playlist)
  echo $playlist
end

function run --argument playlist
  set -q playlist[1]; or set playlist $PLAYLIST
  set -q playlist[1]; or set playlist "default"
  echo $playlist
end
