"""
Hour and minute hand rotation calculationss are separate because
hour and minute hand are separate objects with different rotations.
This class serves to simply calculate those rotations
"""
class_name RotationCalculator


static var _hour_radians: float = 2.0 * PI / 12.0
static var _minute_radians: float = 2.0 * PI / 60.0
static var _minutes_in_hour: int = 60

# assumes that passed time is valid
# rotates hour hand to match the provided time
static func rotate_hour_hand(time: Vector2) -> float:
	return time.x * _hour_radians + (time.y / _minutes_in_hour) * _hour_radians

# assumes that passed time is valid
# rotates minute hand to match the provided time
static func rotate_minute_hand(time: Vector2) -> float:	
	return time.y * _minute_radians
