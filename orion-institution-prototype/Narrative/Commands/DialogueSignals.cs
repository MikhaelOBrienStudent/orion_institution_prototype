using Godot;
using YarnSpinnerGodot;
using System;

public partial class DialogueSignals : Node
{
	[Export] public DialogueRunner dialogueRunner;
	[Export] public InMemoryVariableStorage memoryStorage;
	
	//Placeholder for if there needs to be any signals sent- otherwise, an external script will notify the dialogue when to begin
	[Signal]
	public delegate void StartDialogueSignalEventHandler();

	public void EndNavigation()
	{
		dialogueRunner.RequestNextLine();
	}

	//Signals relating to setting up the scene

	//Update where a character is
	[Signal]
	public delegate void SetCharacterLocationSignalEventHandler(string character_name, string character_location);
	[YarnCommand("SetCharacterLocation")]
	public void SetCharacterLocation(string character_name, string character_location)
	{
		EmitSignal(SignalName.SetCharacterLocationSignal, character_name, character_location);
	}

	//Remove a character from all locations
	[Signal]
	public delegate void RemoveCharacterSignalEventHandler(string character_name);
	[YarnCommand("RemoveCharacter")]
	public void RemoveCharacter(string character_name)
	{
		EmitSignal(SignalName.RemoveCharacterSignal, character_name);
	}

	[Signal]
	public delegate void ChangePlayerLocationSignalEventHandler(string location_name);
	[YarnCommand("ChangeLocation")]
	public void ChangePlayerLocation(string location_name)
	{
		memoryStorage.SetValue("$current_location", location_name);
		EmitSignal(SignalName.ChangePlayerLocationSignal, location_name);
	}



	
	//To be used for playing sfx from the dialogue script. The sound name should be the name of the file to be used
	[Signal]
	public delegate void PlaySoundSignalEventHandler(string sfx_name, float sfx_volume);
	[YarnCommand("PlaySound")]
	public void PlayWorldSFX(string sfx_name, float sfx_volume = 1.0f)
	{
		EmitSignal(SignalName.PlaySoundSignal, sfx_name, sfx_volume);
	}
	


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
