extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var character = "?"
export (Color) var onColor;
export (Color) var offColor;
export (Color) var doneColor;

export (Vector2) var charSize;

var textNode = null
var id = 0;

var done = false
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.



func containsPos(pos):
    var g = pos - global_position
    g.x = abs(g.x)
    g.y = abs(g.y)
    return g.x < charSize.x/2 && g.y < charSize.y/2

    #return (global_position - pos).length_squared() < 10 * 10


func highlightCharacter():
    modulate = onColor

func unhighlightCharacter():
    modulate = offColor

var mousePressed = false
var containsMouse = false

func _input(event):
    return
    """
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed and containsMouse:
            mousePressed = true
            if (textNode.clickedItem != null && textNode.clickedItem != self):
                textNode.addConnection(self, textNode.clickedItem)
                textNode.clickedItem = null
            else:
                textNode.clickedItem = self
    """
        



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var mousePos = get_global_mouse_position()
    if containsPos(mousePos): 
        containsMouse = true
        highlightCharacter()
    else:
        unhighlightCharacter()
        containsMouse = false
    
    if done:
        modulate = doneColor
        
    
