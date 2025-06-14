extends CharacterBody2D

func _process(_delta: float) -> void:
	move_and_slide()

func _on_hurtbox_component_hurtbox_hit(hitbox:HitboxComponent):
	print("YEEOWCH!")
	print("Taking ", hitbox.hitbox_data.damage, " damage!")

