using UnityEngine;
using System.Collections;

public class MenuScript : MonoBehaviour {

	public static int myButtonWidth = 200;
	public static int myButtonHeight = 50;
	
	//Buttons to return to Game and InstructionScene
	void OnGUI () 
	{		
		
		GUI.backgroundColor = Color.cyan;
		
		GUI.contentColor = Color.white;
	
		
		if(GUI.Button(new Rect (Screen.width / 7 - myButtonWidth / 7,  Screen.height / 4.0f - myButtonHeight / 4.0f, myButtonWidth, myButtonHeight), "New Game/Continue"))
		{
			Application.LoadLevel("PartyScreen");
		}	
		
		if(GUI.Button(new Rect (Screen.width / 7 - myButtonWidth / 7, Screen.height / 2.0f - myButtonHeight / 2.0f, myButtonWidth, myButtonHeight), "Options"))
		{
			Application.LoadLevel("Settings");
		}
		
		if(GUI.Button(new Rect (Screen.width / 7 - myButtonWidth / 7, Screen.height / 1.25f - myButtonHeight / 1.25f, myButtonWidth, myButtonHeight), "Credits"))
		{
			Application.LoadLevel("Credits");
		}
	}
}