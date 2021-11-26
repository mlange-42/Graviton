class_name Math

static func angle_deg_between(from, to) -> float:
	var angle = to - from
	return mod(angle + 180, 360) - 180

static func mod(a, n):
	return a - floor(a/n) * n 
