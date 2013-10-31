using UnityEngine;
using System.Collections;

public class SubSettingsButton : MonoBehaviour {

	void OnMouseUp()
	{
		Application.LoadLevel("Settings");
	}
}
