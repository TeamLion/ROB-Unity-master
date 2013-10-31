using UnityEngine;
using System.Collections;

public class CameraFollow : MonoBehaviour {
	
	public Bomb PlayerBomb;
	
	void Update () {
	
		transform.position = new Vector3(PlayerBomb.transform.position.x, PlayerBomb.transform.position.y, PlayerBomb.transform.position.z - 10);
	}
}
