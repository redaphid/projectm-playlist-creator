#!/usr/bin/env fish
function get_playlist --argument playlist
  set -q playlist[1]; or set playlist $PLAYLIST
  set -q playlist[1]; or set playlist "default"
  echo $playlist
end

function get_project_m_dir
  echo "$HOME/tools/projectM"
end

function get_playlist_dir
  echo "$HOME/tools/projectM/presets"
end

function select --argument playlist
  set playlist (get_playlist $playlist)
  echo $playlist
end

function run --argument directory
  set playlist (get_playlist $playlist)
  set playlist_dir (get_playlist_dir)
  set project_m_dir (get_project_m_dir)
  $project_m_dir/projectMSDL --presetPath $playlist_dir/$playlist 2>$project_m_dir/projectM.log
end


function get_current_visualizer
  ps -ef | grep projectM | grep -v grep | awk '{print $8}'
end
