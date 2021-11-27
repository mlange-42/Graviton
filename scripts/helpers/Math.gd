class_name Math

static func angle_deg_between(from: float, to: float) -> float:
	var angle = to - from
	return fposmod(angle + 180.0, 360.0) - 180.0
