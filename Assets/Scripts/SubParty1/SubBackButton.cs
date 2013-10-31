using UnityEngine;
using System.Collections;

public class SubBackButton : MonoBehaviour {

	void OnMouseUp()
	{
		Application.LoadLevel("PartyScreen");
	}
}
