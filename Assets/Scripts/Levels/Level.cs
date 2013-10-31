using UnityEngine;
using System.Collections;

public class Level : MonoBehaviour {
	
	public Bomb PlayerBomb;
	public float YMargin;
	public bool bIsGameOn;
	protected GameObject[] mPillar;
	protected GameObject[] mPlatform;
	protected GameObject[] mGoal;
	

	// Use this for initialization
	public void Begin () { 
		
		mPillar = GameObject.FindGameObjectsWithTag("Pillar");
		mPlatform = GameObject.FindGameObjectsWithTag("Platform");
		mGoal = GameObject.FindGameObjectsWithTag("Goal");
		
		//If the Cube falls bellow this Y the player beats the level
		YMargin = 0.1f;
		
		//Is false when the level has been beaten
		bIsGameOn = true;
	}
	
	// Update is called once per frame
	public void UpdateLevel () {
		
		bIsGameOn = false;
		PlayerBomb.bCanReset = true;
		PlayerBomb.bCanShoot = true;
		
		
		//Checks to see if the pillars are barely or not moving at all
		foreach(GameObject pillar in mPillar){
			
			if(pillar != null)
			{
				if(!pillar.rigidbody.IsSleeping() && pillar.rigidbody.velocity.magnitude == 0){
					PlayerBomb.bCanReset = false;
					PlayerBomb.bCanShoot = false;
				}
			}
			
		}
		
		//Checks to see if the platforms are barely or not moving at all
		foreach(GameObject platform in mPlatform){
			if(!platform.rigidbody.IsSleeping() && platform.rigidbody.velocity.magnitude == 0){
				PlayerBomb.bCanReset = false;
				PlayerBomb.bCanShoot = false;
			}
		}
		
		//Checks to see if the Cube got knocked down
		foreach(GameObject goal in mGoal){
			if(goal.rigidbody.position.y > YMargin){
				bIsGameOn = true;
			}
		}
		
		if(Input.GetKey(KeyCode.Escape)){
			Application.LoadLevel("Menu");
		}
		
	}
	
	void OnCollisionEnter(Collision collision)
	{
		if(Pillar.objectToDestroy != null)
		{
		if(collision.gameObject.GetInstanceID().Equals(Pillar.objectToDestroy.GetInstanceID()))
		{
			//Debug.Log("COL OBJ: " + collision.gameObject.GetInstanceID());
			//Debug.Log("PIL OBJ: " + Pillar.objectToDestroy.GetInstanceID());
			Destroy(collision.gameObject);
		}
		}
	}
}
