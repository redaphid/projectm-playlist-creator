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
  echo "$HOME/tools/projectM/playlists"
end

function select --argument playlist
  set playlist (get_playlist $playlist)
  echo $playlist
end

function run --argument directory
  set playlist (get_playlist $playlist)
  set playlist_dir (get_playlist_dir)
  set project_m_dir (get_project_m_dir)
  ls $playlist_dir/$playlist
  $project_m_dir/projectMSDL --presetPath $playlist_dir/$playlist 2> $project_m_dir/projectM.log
end


function get_current_visualizer --argument playlist
  set -q playlist[1]; or set playlist $PLAYLIST
  set -q playlist[1]; or set playlist "default"

  set visualizer_log (tail -n 1 $HOME/tools/projectM/projectM.log)
  echo "Log:" $visualizer_log
  set visualizer_name (string split ":" $visualizer_log)[3]
  # echo character length before trim
  echo "Length:" (string length $visualizer_name)

  # trim spaces
  set visualizer_name (string trim $visualizer_name)[1]
  # echo character length after trim
  echo "Length:" (string length $visualizer_name)
  # get playlist directory
  set playlist_dir (get_playlist_dir)
  # search for a file that has a name that contains the visualizer name
  echo "Searching for visualizer: '" $visualizer_name
  set visualizer_file (find $playlist_dir/$playlist/ | grep -i $visualizer_name)
  echo "Found visualizer: '" $visualizer_file "'"
end
