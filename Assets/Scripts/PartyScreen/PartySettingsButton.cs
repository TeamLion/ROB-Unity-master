using UnityEngine;
using System.Collections;

public class PartySettingsButton : MonoBehaviour {

	void OnMouseUp()
	{
		Application.LoadLevel("Settings");
	}
}