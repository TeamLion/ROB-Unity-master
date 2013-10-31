using UnityEngine;
using System.Collections;

public class Bomb : MonoBehaviour {
	
	Vector3 mouseTemp;
	Vector3 MousePos;
	Vector3 BallPos;
	Vector3 TempPos;
	public Vector3 Direction;

	float mTime;
	float fDelay;
	public float Force;
	
	public bool bCanShoot;
	public bool bCanReset;
	
	public GameObject reticle;
	
	ArrayList list = new ArrayList();
	
	private int counter;
	public static int AmmoLeft;
	public static int shotsLeft;
	
	public TrailScript trail;
	
	public static string TotalScore;

	private IEnumerator FollowMouse(Vector3 ObjectPos, Vector3 MousePos)
	{
		float t = 0.0f;
		Vector3 originalPos = ObjectPos;
		
		while(t < 0.3f)
		{
			rigidbody.position = Vector3.Lerp(originalPos, transform.position, t);
			t += Time.deltaTime;
			yield return null;
		}
	}

	// Use this for initialization
	void Start () {
		mTime = 0;
		fDelay = 0;
		BallPos.x = 0;
		BallPos.y = 2;
		BallPos.z = 0;
		rigidbody.useGravity = false;
		bCanShoot = true;
		bCanReset = true;		
		reticle.collider.enabled = false;
		reticle.transform.position = new Vector3(rigidbody.position.x, rigidbody.position.y, rigidbody.position.z);
		shotsLeft = ShotsFired.GetShotsFired(gameObject);
	}
	
	// Update is called once per frame
	void Update () {
		
		TotalScore = counter.ToString();
		
		//Pull
		if(Input.GetMouseButton(0) && bCanShoot){
			rigidbody.useGravity = false;
			mTime += Time.deltaTime;
			fDelay += Time.deltaTime;
			
			if(mTime >= 2)
				mTime = 2;
			
			mouseTemp = Input.mousePosition;
			mouseTemp.z = mTime;
			MousePos = Camera.main.ScreenToWorldPoint(mouseTemp);
 			MousePos.z = -1*mTime;	

						
			Direction = BallPos - MousePos;
			Direction.Normalize();	

				
			//Set boundries to how much you can pull
			if(MousePos.x > 3)
				MousePos.x = 3;
			if(MousePos.x < -3)
				MousePos.x = -3;
			
			if(MousePos.y > 5)
				MousePos.y = 5;
			if(MousePos.y < 0)
				MousePos.y = 0;
			
			
			StartCoroutine(FollowMouse(transform.position, MousePos));
			//transform.position = MousePos;
			Force = 13 * mTime;
			
			reticle.transform.position =  new Vector3(Direction.x * 10, Direction.y * 10, Direction.z * 10);
				
			/*if(fDelay >= 0.1f) {
				TrailScript Trail;
				Trail = (TrailScript)Instantiate(trail, rigidbody.position, rigidbody.rotation);
				Trail.LaunchTrail(Direction, Force, BallPos);
				fDelay = 0;
				Destroy(Trail);
			}*/
		}
				
		//Return player to original position
		if(Input.GetKey (KeyCode.R)){
			mTime = 0;
			Force = 0;
			rigidbody.useGravity = false;
			rigidbody.rotation = new Quaternion(0,0,0,0);
			rigidbody.freezeRotation = true;
			rigidbody.velocity = new Vector3(0,0,0);
			transform.position = new Vector3(0,2,0);
			bCanShoot = true;
			bCanReset = true;
		}
		
		//FIRE!
		if(Input.GetMouseButtonUp(0) && bCanShoot){	
			
			shotsLeft -= 1;			
			
			rigidbody.useGravity = true;
			rigidbody.velocity = Direction * Force;
			mTime = 0;
			Force = 0;
			bCanShoot = false; 
			bCanReset = false;
		}

	}
	
	void OnCollisionEnter (Collision collision)
	{
		//bAnimFOV = false;
		GameObject obj = GameObject.FindGameObjectWithTag ("Points");
		
							TextMesh mesh = (TextMesh)obj.GetComponent ("TextMesh");
		mesh.text = string.Empty;
		mesh.renderer.enabled = true;
		
		
		foreach (ContactPoint point in collision.contacts) {			
			
			if (list.Contains (collision.gameObject.GetInstanceID()) == false) 
			{		
				list.Add (collision.gameObject.GetInstanceID());
				
				if (collision.rigidbody != null) 
				{
					if (collision.rigidbody.velocity.magnitude > 1) 
					{
						if (collision.collider.tag == "Pillar") 
						{													
							mesh.text = "100";
							int tempCounter = int.Parse (mesh.text);
							counter += tempCounter;
							TempPos.x = collision.gameObject.rigidbody.position.x;
							TempPos.y = collision.gameObject.rigidbody.position.y + 1;
							TempPos.z = collision.gameObject.rigidbody.position.z;
							
							mesh.transform.position = TempPos;
						}
						
						if (collision.gameObject.tag == "Platform") 
						{
							mesh.text = "300";
							int tempCounter = int.Parse (mesh.text);
							counter += tempCounter;
							TempPos.x = collision.gameObject.rigidbody.position.x;
							TempPos.y = collision.gameObject.rigidbody.position.y + 1;
							TempPos.z = collision.gameObject.rigidbody.position.z;
							
							mesh.transform.position = TempPos;
						}
						
						if (collision.gameObject.tag == "Goal") 
						{
							mesh.text = "500";
							int tempCounter = int.Parse (mesh.text);
							counter += tempCounter;
							TempPos.x = collision.gameObject.rigidbody.position.x;
							TempPos.y = collision.gameObject.rigidbody.position.y + 1;
							TempPos.z = collision.gameObject.rigidbody.position.z;
							
							mesh.transform.position = TempPos;
						}
					}
				}
			}			
		}
	}
	
	void OnGUI()
	{
		GUIStyle style = new GUIStyle();
		style.normal.textColor = Color.magenta;
		style.fontSize = 20;
		GUI.Label(new Rect(0, 35, 100, 30), "Shots Left: " + ShotType.GetShotType(gameObject) + ": " + shotsLeft, style);
	}
}
