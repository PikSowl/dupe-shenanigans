class_name SaveSystem
## Save manager

## Path to the save file
const PATH : String = "user://save.tres"
## Do we want to load the game
const SHOULD_LOAD : bool = false


# Saves Game.ref.data to file
static func save_data() -> void:
	ResourceSaver.save(Game.ref.data, PATH)


## Loads the data and overrides Game.ref.data
static func load_data() -> void:
	if not SHOULD_LOAD:
		return
	
	if ResourceLoader.exists(PATH):
		Game.ref.data = SafeResourceLoader.load(PATH)
