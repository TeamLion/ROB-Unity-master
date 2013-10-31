using UnityEngine;
using System.Collections;

public class PartyBackButton : MonoBehaviour {

	void OnMouseUp()
	{
		Application.LoadLevel("Menu");
	}
}
