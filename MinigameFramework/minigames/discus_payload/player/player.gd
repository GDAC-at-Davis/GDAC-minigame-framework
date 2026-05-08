extends CharacterBody2D

## track change in angle 
@export var angle_change_speed : float = 0.0


## the max torque that is applied 
@export var max_speed : float

## the curve modifying the torque based on distance mouse travels 
@export var torque_curve : Curve

## the curve that modifyis the torque based on how long the player held down the button
@export var time_modifier : Curve
