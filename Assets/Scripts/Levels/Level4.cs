using UnityEngine;
using System.Collections;

public class Level4 : Level {

	// Use this for initialization
	void Start () { 
		Begin();
		
	}
	
	// Update is called once per frame
	void Update () {
		UpdateLevel();
		
		if(bIsGameOn == false){
			Application.LoadLevel("Level5");
		}
		
		
		if(Input.GetKey(KeyCode.Space)){
			Application.LoadLevel("Level4");
		}
	}
}
