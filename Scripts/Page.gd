extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var storyScript = get_node("../../StoryScript")
export (int) var pageIndex = 0
var currentText = "none"
var text;
var unsolvedText = "\nUntranslated..."

export (bool) var isPageSolved = false

# Called when the node enters the scene tree for the first time.
func _ready():

    text = storyScript.getPageText(pageIndex)
    #updateText()
    onPageActiveate()
    for child in get_children():
        if child.has_signal("SolvedSignal"):
            child.connect("SolvedSignal", self, "_onSolveUpdate")

func checkIfPageSolved():
    for child in get_children():
        if child.has_method("lineIsSolved"):
            if !child.lineIsSolved(): return false
    return true

func updateText():
    if (isPageSolved):
        currentText = text
    else:
        currentText = unsolvedText

func _onSolveUpdate(singleItemSolved):
    isPageSolved = checkIfPageSolved()
    onPageActiveate()

func onPageActiveate():
    updateText()
    SignalManager.emit_signal("SetTranslation", currentText)

var hasSet = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if (pageIndex == 0 && !hasSet):
        hasSet = true
        SignalManager.emit_signal("SetTranslation", currentText)
