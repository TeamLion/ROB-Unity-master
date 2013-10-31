using UnityEngine;
using System.Collections;
using System.Text.RegularExpressions;

public class ObjectsHP : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public static int GetObjectsWithHP(GameObject objectToDestroy)
	{
		int hitPoints = 0;
		
		if(objectToDestroy.name.Equals("Pillar"))
		{
			string levelForIncreasedDifficulty = Application.loadedLevelName;
			var digitMatch = Regex.Match(levelForIncreasedDifficulty, "(?<=-l)\\d+");
			Debug.Log("Level: " + levelForIncreasedDifficulty + ": " + digitMatch + ":" + digitMatch.Groups[0].Value);
			
			hitPoints = 3;
		}
		else if(objectToDestroy.name.Equals("Platform"))
		{
			hitPoints = 4;
		}
		else if(objectToDestroy.name.Equals("Goal"))
		{
			hitPoints = 5;
		}
		
		
		return hitPoints;
	}
}
