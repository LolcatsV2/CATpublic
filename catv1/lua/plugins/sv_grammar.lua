/*=======================
=Grammar module, created=
=======by Lolcats========
=======================*/

local FilterWords = {
		i = "I",
		u = "you",
		cuz = "because",
		r = "are",
		im = "I'm",
		didnt = "didn't",
		doesnt = "doesn't",
		calender = "calendar",
		definately = "definitely",
		thru = "through",
		doesent = "doesn't",
		dosnt = "doesn't",
		wierd = "weird",
		gotta = "have to",
		gonna = "going to",
		thier = "their",
		alot = "a lot",
		absolutly = "absolutely",
		ur = "your",
		omg = "oh my god",
		omfg = "oh my fucking god",
		wtf = "what the fuck",
		tbh = "to be honest",
		usa = "United States of America",
		wont = "won't",
		dont = "don't",
		cant = "can't",
		theyre = "they're",
		lol = "haha",
		rofl = "haha",
		gay = "homosexual",
		hax = "hacks",
		teh = "the",
		lagging = "lag",
		lagspike = "lag",
		lagspiked = "lag",
		lagg = "lag",
		lags = "lag",
		bbl = "be back later",
		brb = "be right back",
		bsod = "blue screen of death",
		pls = "please",
		plz = "please",
		hai = "hey",
		haitut = "hey to you too",
		bbiab = "be back in a bit",
		afaicr = "as far as I can recall",
		afaik = "as far as I know",
		asap = "as soon as possible",
		atm = "at the moment",
		cya = "see ya",
		faq = "frequently asked questions",
		ffs = "for fucks sake",
		ftw = "for the win",
		flt = "for the lose",
		gtg = "got to go",
		g2g = "got to go",
		haxor = "hacker",
		motd = "message of the day",
		ty = "thanks",
		np = "no problem",
		wtg = "way to go",
		wth = "what the hell",
		nub = "noob",
	}
	
	
-- Thanks to ASSMod for help with this. <3
function replacedumb( ply, txt )
	
	if (!CAT_Config.EnableDumbass) then return end
	
		local RetText = " "..string.lower( txt ).." "
		
		for k, v in pairs( FilterWords ) do
			RetText = string.Replace( RetText, " "..k.." ", " "..v.." " )
		end
		
		RetText = string.Trim( RetText )
		
		local UpperText = string.upper( string.sub( RetText, 0, 1 ) )
		
		RetText = UpperText..""..string.sub( RetText, 2, string.len( RetText ) )
		
		if not string.find( string.sub( RetText, string.len( RetText ) ), "%p" ) then
			RetText = RetText.."."
		end
		
		if ply:GetNWBool( "cat_ismuted" ) then return end
		if ply:GetNWBool( "cat_isgimped" ) then return end
		
		
		return RetText
	
end
hook.Add( "PlayerSay", "ReplaceDumbass", replacedumb)
		
		
		
		
		
		
		
		
		
		
		
		
		
		