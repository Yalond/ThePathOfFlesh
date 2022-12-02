extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var done = $Done;
onready var ok = $OK;
onready var plug = $Plug;
onready var grab = $Grab;
onready var cancel = $Cancel;

# Called when the node enters the scene tree for the first time.
func _ready():
    Globals.sounds = self
    SignalManager.connect("PlaySound", self, "playSound")

func playSound(name):
    if name == "done":
        done.play()
    elif name == "ok":
        ok.play()
    elif name == "plug":
        plug.play()
    elif name == "grab":
        grab.play()
    elif name == "cancel":
        cancel.play()











# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
