extends AudioStreamPlayer

# There has to be a better way to play multiple streams at once without
# having to resort to this. I've checked AudioStreamPolyphonic but I'm
# not entirely sure how good it is for this specific purpose of having
# multiple pop noises playing at once and at different offsets.

func play_sound(sound: Resource):
	# Play a sound that automatically sets itself free once finished
	self.stream = sound
	self.connect("finished", self._on_audio_stream_end)
	self.play()

func _on_audio_stream_end():
	#print("Audio complete!")
	queue_free()
