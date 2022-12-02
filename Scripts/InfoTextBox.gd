extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var continueButton = $ContinueButton
onready var textBox = $Panel/TextBox

# Called when the node enters the scene tree for the first time.
func _ready():
    #visible = false
    SignalManager.connect("SetTranslation", self, "_onSetTranslation")
    SignalManager.connect("SetTranslationBoxVisibility", self, "_onDisplayBox")
    continueButton.connect("pressed", self, "_hideMenu")

func _onSetTranslation(text):
    #visible = true
    textBox.bbcode_text = text

func _hideMenu():
    pass
    #visible = false

func _onDisplayBox(shouldShow):
    visible = shouldShow


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
