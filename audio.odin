package raycity
import rl "vendor:raylib" 
import "core:strings"


Audio_system :: struct {
   is_playing: []bool,
   tracks: []rl.Music,
   volumes: []f32,

}

init_audio :: proc (files: []cstring) -> Audio_system {
   track_count := len(files); 
   tracks := make([]rl.Music, track_count);
   is_playing := make([]bool, track_count);
   volumes := make([]f32, track_count);

   for i in 0..<track_count {
      tracks[i] = rl.LoadMusicStream(files[i]);
      is_playing[i] = false;
      volumes[i] = 1.0

   }

   return Audio_system {
      tracks = tracks,
      is_playing = is_playing,
      volumes = volumes,
   }
}

start_track :: proc (audio: ^Audio_system, track_index: int) {
   if track_index >= 0 && track_index < len(audio.tracks) {
      rl.PlayMusicStream(audio.tracks[track_index]);
      audio.is_playing[track_index] = true;
   }
}

stop_track :: proc (audio: ^Audio_system, track_index: int) {
   if track_index >= 0 && track_index < len(audio.tracks) {
      rl.StopMusicStream(audio.tracks[track_index]);
      audio.is_playing[track_index] = false;
   }
}
