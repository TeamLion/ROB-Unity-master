using UnityEngine;
using System.Collections;

public class OneOne : MonoBehaviour {

	// Use this for initialization
	void OnMouseUp()
	{
		if(GameObject.Find("1-1"))
		{
			Application.LoadLevel("Level1");
		}
	}
}
