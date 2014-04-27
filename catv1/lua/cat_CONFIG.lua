// Config file for CAT.
// Pretty much if you want to change something, it's here.
// Also, if you break something in here, I'm going to cry.

CAT_Config = CAT_Config or {}

// CAT_Config.UseCatTags
// Whether or not to use my chat tags.
// Special note: Requires a server restart or clients to rejoin to take effect.Possible values: true false. Default Value: false
CAT_Config.UseCatTags = false

// CAT_Config.UseCatMOTD
// Whether or not to use CAT's MOTD. Possible values: true false. Default Value: true
CAT_Config.UseCatMOTD = true

// CAT_Config.MOTDURL
// WThe link to be used when the MOTD opens. Possible values: Any string (I.E. "www.google.com"). Default Value: "www.google.com"
CAT_Config.MOTDURL = "www.google.com"

// CAT_Config.UserGroups
// What usergroups to use. There is little support for custom usergroups, and you're probably going to have to ask me how to do it. Will be fixed in a later update.  Possible values: See example.
// Special note: Requires a server restart to take full effect.
CAT_Config.UserGroups = {
"user",
"vip",
"moderator",
"admin",
"superadmin",
"owner"
}

// CAT_Config.TellAll
// Whether or not to broadcast admin actions to everyone. Possible values: true false. Default Value: true
CAT_Config.TellAll = true

// CAT_Config.TellAdmins
// Whether or not to broadcast admin actions to other admins, regardless of CAT_Config.TellAll and CAT_Config.TellAnonymous. Possible values: true false. Default value: true
CAT_Config.TellAdmins = true

// CAT_Config.TellAnonymous
// Whether or not to broadcast admin actions anonymously. If CAT_Config.TellAdmins is true, then admins will see other admin actions regardless of this setting. Possible values: true false. Default value: false
CAT_Config.TellAnonymous = false

// CAT_Config.LogNoclip
// Whether or not to log noclip actions to the console (I.E. PLAYER -> entered Noclip). Possible values: true false. Default value: false.
CAT_Config.LogNoclip = false

// CAT_Config.EnableDumbass
// Whether or not to enable the dumbass text filter (AKA fix grammar). Possible values: true false. Default value: false.
CAT_Config.EnableDumbass = false

// CAT_Config.GiveRagWeps
// What weapons to give back to a player after being ragdolled. Possible values are any weapon type.
CAT_Config.GiveRagWeps = {
"weapon_physcannon",
"weapon_physgun",
"weapon_frag",
"weapon_rpg",
"gmod_tool",
"weapon_crowbar",
"weapon_pistol",
"weapon_357",
"weapon_smg1",
"weapon_ar2",
"weapon_shotgun",
"weapon_crossbow",
"gmod_camera"
}

// CAT_Config.GimpMessages
// What the gimp messages should be. Possible values: Any string.
CAT_Config.GimpMessages = {
	"kill me",
	"i love it when the admin physguns me off a building",
	"i wouldnt mind getting slayed 5 times",
	"admin? can u jail me?",
	"where do babys come fom?",
	"being gimpped is the greatest thing ive ever had done to me"
}

// CAT_Config.userCan
// What users are allowed to do. Possible values: See Example.
// "isadmin" check for TellAdmins. Nothing else.
CAT_Config.userCan = {"noclip"}

// CAT_Config.vipCan
// What VIP users are allowed to do. Possible values: See above.
CAT_Config.vipCan = {"noclip"}

// CAT_Config.moderatorCan
// What player moderators are allowed to do. Possible values: See above.
CAT_Config.moderatorCan = {"blind",
"isadmin",
"seizure",
"ragdoll",
"armor",
"ban",
"bring",
"cuprops",
"stopsounds",
"cleardecals",
"cloak",
"extinguish",
"freeze",
"god",
"health",
"noclip",
"ignite",
"kick",
"goto",
"slay",
"uncloak",
"unfreeze",
"ungod"
}

// CAT_Config.adminCan
// What admins are allowed to do. Possible values: See above.
CAT_Config.adminCan = {"blind",
"isadmin",
"seizure",
"ragdoll",
"armor",
"ban",
"setspeed",
"bring",
"cuprops",
"cleardecals",
"cloak",
"extinguish",
"freeze",
"stopsounds",
"god",
"health",
"noclip",
"ignite",
"kick",
"goto",
"slay",
"uncloak",
"unfreeze",
"ungod"
}

// CAT_Config.superadminCan
// What superadmins are allowed to do. Possible values: See above.
CAT_Config.superadminCan = {"blind",
"isadmin",
"seizure",
"rcon",
"ragdoll",
"rocket",
"setspeed",
"stopsounds",
"give",
"gimp",
"armor",
"ban",
"cleanserver",
"goto",
"bring",
"voicemute",
"cuprops",
"cleardecals",
"mute",
"cloak",
"slap",
"extinguish",
"freeze",
"god",
"train",
"health",
"noclip",
"changemap",
"strip",
"ignite",
"kick",
"cexec",
"slay",
"uncloak",
"unfreeze",
"ungod",
"screencap",
"setaccess"
}

// CAT_Config.ownerCan
// What Owners are allowed to do. Possible values: See above.
CAT_Config.ownerCan = {"blind",
"isadmin",
"seizure",
"rcon",
"ragdoll",
"rocket",
"setspeed",
"stopsounds",
"give",
"gimp",
"armor",
"ban",
"cleanserver",
"goto",
"bring",
"voicemute",
"cuprops",
"cleardecals",
"mute",
"cloak",
"slap",
"extinguish",
"freeze",
"god",
"train",
"health",
"noclip",
"changemap",
"strip",
"ignite",
"kick",
"cexec",
"slay",
"uncloak",
"unfreeze",
"ungod",
"screencap",
"setaccess"
}











