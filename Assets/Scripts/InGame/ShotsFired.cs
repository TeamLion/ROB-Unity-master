using UnityEngine;
using System.Collections;

public class ShotsFired : MonoBehaviour {
	
	public static GameObject TypeOfShotsFired;
	public static int numberOfShotsLeft;
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public static int GetShotsFired(GameObject shotsFired)
	{
		TypeOfShotsFired = shotsFired;
		
		if(TypeOfShotsFired.name.Equals("PlayerBomb"))
		{
			numberOfShotsLeft = 10;
		}		
//		else if (TypeOfShotsFired.name.Equals("PlayerBomb2"))
//		{
//			numberOfShotsLeft = 30;
//		}
//		else if(TypeOfShotsFired.name.Equals("PlayerBomb3"))
//		{
//			numberOfShotsLeft = 20;
//		}
//		else if(TypeOfShotsFired.name.Equals("PlayerBomb4"))
//		{
//			numberOfShotsLeft = 10;
//		}
//		else if(TypeOfShotsFired.name.Equals("PlayerBomb5"))
//		{
//			numberOfShotsLeft = 5;
//		}
		
		return numberOfShotsLeft;
	}
}
