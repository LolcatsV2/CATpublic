// Config file for CAT.
// Pretty much if you want to change something, it's here.
// Also, if you break something in here, I'm going to cry.

CAT_Config = CAT_Config or {}



// CAT_Config.UseCATPP
// Whether or not to use CAT Prop Protection. This is useful if you are running DarkRP or something that comes with a Prop Protection, or if you don't like my prop protection. Possible Values: true false. Default Value: true
// Special note: Requires a server restart to take full effect.
CAT_Config.UseCATPP = true

// CAT_Config.AdminsTouchPlayerProps
// Whether or not admins are allowed to touch other player's props (CATPP required). Possible Values: true false. Default Value: true
// Special note: Requires a server restart to take full effect.
CAT_Config.AdminsTouchPlayerProps = true

// CAT_Config.AdminsTouchWorldProps
// Whether or not admins are allowed to physgun/gravgun/toolgun world props (doors, map spawned stuff, entites, etc). (CATPP required) Possible Values: true false. Default Value: true
CAT_Config.AdminsTouchWorldProps = true

// CAT_Config.DisconCleanupTime
// How long to wait until cleaning up disconnected players props (CATPP required). Possible values: any number in seconds. Default Value: 15
CAT_Config.DisconCleanupTime = 15

// CAT_Config.AntispamTime
// How long to wait between spawning props before it triggers the antispam (CATPP required). Possible Values: any number in seconds. Default Value: 0.4
CAT_Config.AntispamTime = 0.4

// CAT_Config.ShouldLogStuff
// Whether or not you want CAT to log player's actions, like spawning props, ragdolls, entering noclip, spraying sprays, etc. THIS WILL BE AUTOMATICALLY DISABLED IF YOU HAVE DARKRP. Possible values: true false. Default Value: true
// Special note: CAT Actions will always be logged (PLAYER -> Did something).
CAT_Config.ShouldLogStuff = true

// CAT_Config.UseCatTags
// Whether or not to use my chat tags. This doesn't work with a lot of custom chatboxes. Experiment! 
// Special note: Requires a server restart or clients to rejoin to take effect. Possible values: true false. Default Value: false
CAT_Config.UseCatTags = false

// CAT_Config.UseCatMOTD
// Whether or not to use CAT's MOTD. Possible values: true false. Default Value: true
CAT_Config.UseCatMOTD = true

// CAT_Config.MOTDURL
// WThe link to be used when the MOTD opens. Possible values: Any string (I.E. "www.google.com"). Default Value: "www.google.com"
CAT_Config.MOTDURL = "www.google.com"


// CAT_Config.UserGroups
// What usergroups to use. There is little support for custom usergroups, and you're probably going to have to ask me how to do it. Will be fixed in a later update.  Possible values: See example.
// Special note: Requires a server restart to take full effect. DON'T JUST PUT GROUPS IN HERE AND EXPECT THEM TO WORK (kinda).
CAT_Config.UserGroups = {
"user",
"mod",
"staff",
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

// CAT_Config.GiveRagWeps
// What weapons to give back to a player after being ragdolled. Possible values are any weapon type.
CAT_Config.GiveRagWeps = {
"weapon_physcannon",
"weapon_physgun",
"gmod_tool",
"gmod_camera"
}

// CAT_Config.GiveAdminWeps
// What weapons to give to admins on spawn.
CAT_Config.GiveAdminWeps = {
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

// CAT_Config.UserCan
// What users are allowed to do. Possible values: See Example.
// "isadmin" check for TellAdmins. Nothing else.
CAT_Config.UserCan = {"noclip"}

// CAT_Config.ModCan
// What moderators are allowed to do. Possible values: See Example.
// "isadmin" check for TellAdmins. Nothing else.
CAT_Config.ModCan = {"kick",
"ban",
"isadmin",
"pickupplayers",
"noclip",
"goto",
"bring"}

// CAT_Config.StaffCan
// What Staff are allowed to do. Possible values: See above.
CAT_Config.StaffCan = {"blind",
"pickupplayers",
"isadmin",
"seizure",
"rcon",
"ragdoll",
"rocket",
"setspeed",
"firework",
"stopsounds",
"give",
"gimp",
"armor",
"enabledevmode",
"ban",
"cleanserver",
"goto",
"bring",
"voicemute",
"cprops",
"cleardecals",
"mute",
"cloak",
"slap",
"extinguish",
"freeze",
"god",
"train",
"sethealth",
"noclip",
"bomb",
"strip",
"ignite",
"kick",
"cexec",
"slay",
"uncloak",
"unfreeze",
"ungod"
}

// CAT_Config.OwnerCan
// What Owners are allowed to do. Possible values: See above.
CAT_Config.OwnerCan = {"blind",
"pickupplayers",
"unban",
"isadmin",
"seizure",
"rcon",
"ragdoll",
"rocket",
"setspeed",
"firework",
"stopsounds",
"give",
"gimp",
"armor",
"enabledevmode",
"ban",
"cleanserver",
"goto",
"bring",
"voicemute",
"cprops",
"cleardecals",
"mute",
"setname",
"setmoney",
"setjob",
"banjob",
"unbanjob",
"cloak",
"slap",
"extinguish",
"freeze",
"god",
"train",
"health",
"noclip",
"observerban",
"bomb",
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
"setaccess",
"panic",
"uberpanic"
}











