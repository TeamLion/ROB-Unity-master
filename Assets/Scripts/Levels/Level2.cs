using UnityEngine;
using System.Collections;

public class Level2 : Level {
	
		private static string TotalScore;
	protected bool paused;
	// Use this for initialization
	void Start () { 
		Begin();
	}
	
	void OnPauseGame()
	{
		paused = true;
		OnGUI();
		
		if(Input.GetKeyDown(KeyCode.A))
		{
			OnResumeGame();
		}
	}
	
	void OnResumeGame()
	{
		paused = false;
		Application.LoadLevel("Level3");
	}
	
	// Update is called once per frame
	void Update () {
		TotalScore = Bomb.TotalScore;
		//Debug.Log(TotalScore);
		
		UpdateLevel();
		
		if(bIsGameOn == false){
			Object[] objects = FindObjectsOfType (typeof(GameObject));
			foreach (GameObject go in objects) 
				{
					go.SendMessage ("OnPauseGame", SendMessageOptions.DontRequireReceiver);
			    }
		}
		
		
		if(Input.GetKey(KeyCode.Space)){
			Application.LoadLevel("Level2");
		}
	}
	
	private void OnGUI()
	{
		if(bIsGameOn == false)
		{
		GUIStyle style = new GUIStyle();
		style.normal.textColor = Color.white;
		style.fontSize = 48;
		int width = Screen.width / 4;
		int height = Screen.height / 2;
		GUI.Label(new Rect(width, height, 300, 100), "Level Score: " + TotalScore, style);
		}
	}
}
