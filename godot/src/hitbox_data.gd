extends Resource
class_name HitboxData
## This resource contains information about how much damage a hitbox should deal, and maybe other info too!!!

@export var damage: float = 1.0

func _init(p_damage: float = 1.0):
	damage = p_damage
