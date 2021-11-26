# walk.rb

use_synth :cnoise
use_synth_defaults res: 0.9, amp: 0.05, attack: 0.02, sustain: 0.02, release: 0.05, cutoff: 90

duration = 0.2
repetitions = 8

with_fx :record,buffer: buffer("walk", repetitions * duration) do
  
  repetitions.times do
    sample :drum_cymbal_closed, cutoff: 70, attack: 0.0, sustain: 0.0, release: 0.01
    sleep duration
  end
  
end