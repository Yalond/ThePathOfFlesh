extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var children = []
var startPos = Vector2.ZERO
var hidePos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
    SignalManager.connect("UpdatePageIndex", self, "_updatePageIndex")
    startPos = get_child(0).global_position
    hidePos = startPos + Vector2(-200, 0)
    var zIndex = 100
    for child in get_children():
        child.z_index = zIndex
        zIndex -= 1

    setActivePage(0)
 

var currentPageIndex = 0

func incrementPageIndex():
    setActivePage(currentPageIndex + 1)

func decrementPageIndex():
    setActivePage(currentPageIndex - 1)

func _updatePageIndex(dir):
    setActivePage(currentPageIndex + dir)

func setActivePage(pageIndex):
    if (pageIndex < 0): pageIndex = 0
    if (pageIndex >= get_child_count()): pageIndex = get_child_count() - 1
    currentPageIndex = pageIndex
    SignalManager.emit_signal("SetPageIndex", currentPageIndex)

    var i = 0
    for child in get_children():

        child.visible = true
        if i == pageIndex:
            child.global_position = startPos
            #child.visible = true
            child.onPageActiveate()
        else:
            child.global_position = hidePos
            #child.visible = false
        i += 1
        

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
