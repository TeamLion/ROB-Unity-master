using UnityEngine;
using System.Collections;

public class CreditsScript : MonoBehaviour {

	// Use this for initialization
	public static int myButtonWidth = 100;
	public static int myButtonHeight = 25;
	
	//Buttons to return to Game and InstructionScene
	void OnGUI () 
	{		
		
		GUI.backgroundColor = Color.cyan;
		
		GUI.contentColor = Color.white;
	
		
		if(GUI.Button(new Rect (Screen.width / 7 - myButtonWidth / 7,  Screen.height / 1.1f - myButtonHeight / 1.1f, myButtonWidth, myButtonHeight), "Back"))
		{
			Application.LoadLevel("Menu");
		}
	}
}
