using UnityEngine;
using System.Collections;

public class Level3 : Level {
	
	// Use this for initialization
	void Start () { 
		Begin();
	}
	
	// Update is called once per frame
	void Update () {
		UpdateLevel();
		
		if(bIsGameOn == false){
			Application.LoadLevel("Level4");
		}
		
		
		if(Input.GetKey(KeyCode.Space)){
			Application.LoadLevel("Level3");
		}
	}
}
