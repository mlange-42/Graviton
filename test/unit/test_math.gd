extends "res://addons/gut/test.gd"

func test_angle_deg_between():
	assert_eq(Math.angle_deg_between(0, 1), 1.0)
	assert_eq(Math.angle_deg_between(1, 0), -1.0)
	
	assert_eq(Math.angle_deg_between(10, 350), -20.0)
	assert_eq(Math.angle_deg_between(350, 10), 20.0)

	assert_eq(Math.angle_deg_between(10, -10), -20.0)
	assert_eq(Math.angle_deg_between(-10, 10), 20.0)
	
	assert_eq(Math.angle_deg_between(1, 180), 179.0)
	assert_eq(Math.angle_deg_between(180, 1), -179.0)
