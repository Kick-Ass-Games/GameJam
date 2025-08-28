extends Camera2D

const yConst = 420 + 35;

func _process(delta:float):
	self.global_position.y = yConst;
