extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var leftButton = $LeftButton
onready var rightButton = $RightButton
onready var pageIndex = $PageIndicator

# Called when the node enters the scene tree for the first time.
func _ready():
    leftButton.connect("pressed", self, "_leftPress")
    rightButton.connect("pressed", self, "_rightPress")
    SignalManager.connect("SetPageIndex", self, "_setPageIndex")
    pageIndex.text = str(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _setPageIndex(pageNum):
    pageIndex.text = str(pageNum + 1)


func _rightPress():
    SignalManager.emit_signal("UpdatePageIndex", 1)
    SignalManager.emit_signal("PlaySound", "ok")

func _leftPress():
    SignalManager.emit_signal("UpdatePageIndex", -1)
    SignalManager.emit_signal("PlaySound", "ok")

