using UnityEngine;
using System.Collections;

public class ShotType : MonoBehaviour {
	
	public static GameObject ShotObject;
	
	// Use this for initialization
	void Start () {
		
		GetShotType(ShotObject);
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public static string GetShotType(GameObject shotObjectType)
	{
		ShotObject = shotObjectType;
		
		return ShotObject.name;
	}
}
