using UnityEngine;
using System.Collections;

public class ScoreKeeper : MonoBehaviour {
	
	private string TotalScore;
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		
		TotalScore = Bomb.TotalScore;
		//Debug.Log("ScoreKeeper: " + TotalScore);
	
	}
	
	void OnGUI()
	{		
		GUIStyle style = new GUIStyle();
		style.normal.textColor = Color.cyan;
		style.fontSize = 24;
		GUI.Label(new Rect(0, 0, 100, 30), "Score: " + TotalScore, style);
	}
}
