
g_PluginInfo =
{
	Name = "Backpack",
	Date = "2017-05-30",
	Description =
	[[
    The plugin makes it possible to have additional slots - a backpack, the opening of which is done with the command /backpack or /bk.
    For viewing and editing it is enough to enter the name of the player after the command, like /backpack Testit.

    The plugin allows you to edit the number of slots, the title and the name of the file to save the data.
	]],

	AdditionalInfo =
	{
		{
			Title = "Configuration",
			Contents =
			[[
        The settings are in the file Settings.lua
        I think explaining how to change them does not make sense.
			]],
		},
	},

	Commands =
	{
		["/backpack"] =
		{
      Alias = "/bp",
			Permission = "backpack.open",
			HelpString = "Open backpack",
			Handler = Backpack,
			Subcommands =
			{
				clean =
					{
						Permission = "backpack.clean",
						Handler = ClearItems,
					},
			},
		},
	},
  Permissions =
  {
	 ["backpack.open"] =
	 {
		  Description = "Opens the player's backpack",
		  RecommendedGroups = "players",
	 },
	 ["backpack.openother"] =
	 {
		  Description = "Opens another player's backpack",
		  RecommendedGroups = "admins, mods",
	 },
 }
};
