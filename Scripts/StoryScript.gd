extends Node2D


var textOld = """
To My Dearest Nephew. Death has found me, and found me well. Most of my possessions will have been passed out to various grasping relatives by now, but I've ensured a few things were kept hidden. I know you've alwys taken an interest in some of my works, and in my library, and the book I'm giving you here is one of the more unsual volumes. I understnad that it's a copy, one of five I beleive, made of an ancient manuscript that came into the possession of a collector of such works several centuries ago. I thought you might enjoy doing a little translating, though I've no notion as to what the language is or where to even begin. The first page perhaps. Good luck my newphew. Your uncle, Montgomery Cunningham.
The Journey Over the Mountains and into the Hollow or, [shake rate=10 level=15][color=red]The Path of Flesh[/color][/shake]
Read well all who care to learn about such things. These words written here describe what has been the obsession of my life for the past years. A heardsman, would you believe, brought into my houshold a stele that he had found, half buried in the desert sands. Such a wonder! Carvings and writings adorned it's face, the likes of which few must have seen before! I myself being a person of somewhat modest means, a few servants, a minor estate, the administrator of a small region, had certainly not come across such a thing as this. I was left witht he problem of what to do with it. Certainly a sum of money could be granted to me if I were to find a collector of such treasures, but in the town I was in, that wasn't likley to be forthcoming. A few letters might be sent, but if others, powerful and unfriendly to me, caught wind of this thing, I wouldn't have it for long. The indignity. There was only one thing for it, I'd sequester it away somewhere. Somewhere where others couldn't reach it.
I found a place to store it, eventually, under one of the outbuildings, the one that i'd not got around to getting fixed after the last storm. I buried it deep in the sands, as I tried to think of how to proceed. After some time, and talking with a few of my aquaintances, I came to realise that translating the stele myself would be the best course of action. There was no way that I was going to give it to anyone else to do, and so that just leaves me. 
I knew a little about languges, having studided them at a nearby place of higher learning for some while. The stele was rather esoteric though. I wasn't aware of the language. Anyway, with trial and effort, taking many months, years even, I finaly succeded in cracking it. After I'd learned it, the tablet actialy broke slightly, showing how much I'd handled it over the last severl months.
The effort seemed wasted. The stelle taked about a path you needed to walk to acquire something. What that path was it didn't make clear, and what the thing was you wanted to acquire was not stated. So, all in all, it was mosty usless. It did give a list of some streatcing exercises, and some minor phrases to rescite before sleep, that were supposed to help clear the mind, and I found they did, to a degree. So, it seemed all my efforts had amounted to nothing more than the aquasitiion of a mediocre sleep tonic. Ah well. To say I was frustrated was an understatement. I actually took a hammar to the stelle in a fit of rage, and knocked a few more chips off it before getting control of myself.
Still though, perhaps I should expand a little more on the contents of the stelle. The sleep phrases considted of a sequence of intertwining mantras. The stelle instructed the reader to hum them in a specific sequence, which oscillated throughout the week, and had to have the current phase of the moon taken into accunt. As the weeks wore on and I continued to recite the phrases, they seemed to result in a odd thickening of my vocal chords, a strange muffing of my voice, and a lightheadedness that grew more intense as the sun sank. The stretches seemed strange to me, odd contortins of arm and leg, pulling sets of muscles in unweildey directions. I felt myself grow strong and limber, but it was a strange strength, and an odd limberness.
My dreams too, started growing longer and stranger. It was as if I was getting a glimpse of a someplace far away, always the same. A yellow desert, a large city in the center. Strange stars wheeled over head. As I aproached the city, it would recede back into the desert, vanisheing. Each night I got a little closer though, and I felt sure with time that I could finally reach this dream construct. 
Then one night it happened, I reached the city, and walked through the streets. What from afar had appeard a grand and magnificent place, instead seemed to speak of fadded opulence. Some walls were knocked down, the sands spread inside buildings, roofs were absent in places. The denizens of the city, such as they were, were loath to speak with me. I questioned them, but most seemed mute. I came back to the place night after night, and eventually pieced togther what had happened there. I still wasn't sure if it was real or only in my head, perhaps it didn't matter. I found a long abandond library, there were a few scrolls left, inscribed with a simmilar language to that of the stele. Their contents were strange and marvelous, and gave me much to consider.
Transcribers note, the orinial manuscript ends here, a new hand picks up giving some final details. I Unaroth, former assistant to Malek, herby do lay down in this book for posterity that Malek, after writing these words, went. I don't know where he went. He took nothing with him. We have been unable to locate him. Please, if you hold this in your hands, just get rid of it. For years my superior obsessed over this, and where did that lead him? I'd destroy it but I can't bring myself to do so, this message will need to suffice.
"""
var text = """
To My Dearest Nephew. Death has found me, and found me well. Most of my possessions will have been passed out to various relatives by now, but kept hidden. I know you've always had an interest in some of my works, and in my library, and the book I'm giving you here is one of the more unusual volumes. I understand that it's a copy, one of five, made of an ancient manuscript. I thought you might enjoy doing a little translating, though I've no notion as to what the language is or where to even begin. The first page perhaps. Good luck. Your uncle, Montgomery Cunningham.
The Journey Over the Mountains and into the Hollow or, [shake rate=10 level=15][color=red]The Path of Flesh[/color][/shake]
These words outline what has been the obsession of my life over the past several years. A herdsman brought into my household a stele that he had found, half buried in the desert sands. Such a wonder! Carvings and writings of incredible detail adorned its face. I hadn’t come across such a thing before. I was left with the problem of what to do with it. I could have tried selling it, or asking some people I know about it, but none of these choices seemed appealing to me at the time. I decided to hide it, somewhere others couldn't reach it.
I found a place to store it, eventually, under one of the outbuildings, the one that I hadn’t got around to getting fixed after the last storm. I buried it deep in the sands, as I tried to think of how to proceed. After some time, and talking with a few of my acquaintances, I came to realize that translating the stele myself would be the best course of action. There was no way that I was going to give it to anyone else to do.
I knew a little about languages, having studied them for some while. The stele was rather esoteric though. I wasn't aware of the language. With trial and effort though, taking many months, I finally succeeded in cracking it. After I'd learned what it had to say, the tablet actually broke slightly, showing how much I'd handled it over the last several months.
The effort seemed wasted. The stele talked about a path you needed to walk to acquire something. What that path was it didn't make clear, and what the thing was you wanted to acquire was not stated. So, all in all, it was mostly useless. It did give a list of some physical and mental exercises to do before sleep, that were supposed to help clear the mind. So, it seemed all my efforts had amounted to essentially nothing. Ah well. To say I was frustrated was an understatement. I actually took a hammer to the stele in a fit of rage, and knocked a few chips from it before getting control of myself.
Still though, perhaps I should expand a little more on the contents of the stele. The mental exercises consisted of a sequence of intertwining mantras. The stele instructed the reader to chant them in a specific sequence, which would change throughout the week. As the months wore on and I continued to recite the phrases, they seemed to result in an odd thickening of my vocal chords, a strange muffing of my voice, and a lightheadedness that grew more intense as the sun went down. The physical exercises seemed strange to me, odd contortions of arm and leg, pulling sets of muscles in unwieldy directions. I felt myself grow strong and limber, but it was a strange strength.
My dreams too, started growing longer and stranger. It was as if I was getting a glimpse of a place far away, always the same. A yellow desert, a large city in the center. Strange stars wheeled over head. As I approached the city, it would recede back into the desert, vanishing. Each night I got a little closer though, and I felt sure with time that I could finally reach this dream construct.
Then one night it happened, I reached the city, and walked through the streets. What from afar had appeared a grand and magnificent place, instead seemed to speak of faded opulence. Some walls were knocked down, the sands spread inside buildings, roofs were absent in places. The denizens of the city, such as they were, were loath to speak with me. I questioned them, but most seemed mute. I came back to the place night after night, and eventually pieced together what had happened there. I still wasn't sure if it was real or only in my head, perhaps it didn't matter. I found a long abandoned library, there were a few scrolls left, inscribed with a similar language to that of the stele. Their contents were strange and marvelous, and gave me much to consider.
Transcribers note, the original manuscript ends here, a new hand picks up giving some final details. I, former assistant to Malek, herby do lay down in this book for posterity that Malek, after writing these words, has gone. I don't know where he went. He took nothing with him. We have been unable to locate him. Please, if you hold this in your hands, just get rid of it. For years my superior obsessed over this, and where did that lead him? I'd destroy it but I can't bring myself to do so, this message will need to suffice.


"""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var letterText = "letter text"
var pageText = []
var outroText = "End text"
var hasGenerated = false


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func generateLines():
    var rawLines = text.split("\n")
    
    var lines = [] 
    for line in rawLines:
        lines.append("\n" + line.replace(". ", ".\n\n") + "\n")
    
    letterText = lines[0]
    outroText = lines[1] 
    pageText = lines.slice(1, len(lines) - 1)

func getPageText(index):
    if !hasGenerated:
        generateLines()
    #print(pageText)
    #return "nothing"
    return pageText[index]






# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
