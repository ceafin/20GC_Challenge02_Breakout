class_name Mob
extends StaticBody2D

enum Type {
	CONE,
	MOLECULE,
	MORPH,
	PYRAMID,
}

var mob_type : Type

var hit_points : int = 1
var speed : float = 100.0
