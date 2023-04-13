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

function run --argument directory
  set playlist (get_playlist $playlist)
  set playlist_dir (get_playlist_dir)
  set project_m_dir (get_project_m_dir)
  ls $playlist_dir/$playlist
  $project_m_dir/projectMSDL --presetPath $playlist_dir/$playlist 2> $project_m_dir/projectM-$playlist.log
end


function get_current_visualizer --argument playlist
  set -q playlist[1]; or set playlist $PLAYLIST
  set -q playlist[1]; or set playlist "default"

  set visualizer_log (tail -n 1 $HOME/tools/projectM/projectM.log)
  set visualizer_name (string split ":" $visualizer_log)[3]
  # echo character length before trim

  # trim spaces
  set visualizer_name (string trim $visualizer_name)[1]

  # get playlist directory
  set playlist_dir (get_playlist_dir)

  set visualizer_files (find $playlist_dir/$playlist/ | grep -i $visualizer_name )
  # sort visualizer files by file name length
  set smallest_length 9999
  for visualizer_file in $visualizer_files
    set visualizer_file_length (string length $visualizer_file)
    if test $visualizer_file_length -lt $smallest_length
      set smallest_length $visualizer_file_length
      set visualizer_file $visualizer_file
      echo "shortest visualizer: '" $visualizer_file "'"
    end
  end
  set visualizer_file $visualizer_files[1]
  echo "Found visualizer: '" $visualizer_file "'"
end
