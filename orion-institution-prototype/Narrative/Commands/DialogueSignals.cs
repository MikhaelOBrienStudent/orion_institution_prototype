using Godot;
using YarnSpinnerGodot;
using System;

public partial class DialogueSignals : Node
{
	[Export] public DialogueRunner dialogueRunner;
	
	//Placeholder for if there needs to be any signals sent- otherwise, an external script will notify the dialogue when to begin
	[Signal]
	public delegate void StartDialogueSignalEventHandler();	
	
	//To be used for playing sfx from the dialogue script. The sound name should be the name of the file to be used
	[Signal]
	public delegate void PlaySoundSignalEventHandler(string sound_name);


	//The Get Name command will tell the other scripts to bring up the input and have the player put in their name, while the set name function is responsible for providing the name back to the dialogue script
	[Signal]
	public delegate void GetNameSignalEventHandler();
	public static string PlayerName = "Placeholder";

	[YarnCommand("GetPlayerName")]
	public void GetPlayerName()
	{
		GD.Print("Signal: Requesting Name Input");
		EmitSignal(SignalName.GetNameSignal);
	}

	//Godot seems to be having issues with accessing the static variables in C# scripts, which is really annoying because the function to pass the name to the dialogue requires a static variable. This workaround lets a gdscript set the name variable without having to access it directly
	public void ChangePlayerName(string NewName)
	{
		PlayerName = NewName;
	}

	[Signal]
	public delegate void HidePlayerInputSignalEventHandler();
	[YarnCommand("HidePlayerInput")]
	public void HidePlayerInput()
	{
		EmitSignal(SignalName.HidePlayerInputSignal);
	}

	[YarnFunction("SetPlayerName")]
	public static string SetPlayerName()
	{
		return PlayerName;
	}

	//Responsible for pausing the dialogue so the player can move around again
	[Signal]
	public delegate void EnableNavigationSignalEventHandler();
	
	[YarnCommand("EnableNavigation")]
	public void EnableNavigation()
	{
		GD.Print("Signal: Enabling Navigation");
		EmitSignal(SignalName.EnableNavigationSignal);
	}
	
	
}
