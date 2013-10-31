using UnityEngine;
using System.Collections;

public class PartyScreenGUI : MonoBehaviour {

	// Use this for initialization
	public static int myButtonWidth = 100;
	public static int myButtonHeight = 25;
	public GameObject prefab;
	public int m_nXAmount;
 	public int m_nXOffset;
	public int m_nYAmount;
 	public int m_nYOffset;
 
 	void Start () 
 	{
		for( int x = 0; x < m_nXAmount; ++x )
		{
			for( int y = 0; y < m_nYAmount; ++y )
			{
				Instantiate( prefab, new Vector3( x * m_nXOffset, y * m_nYOffset, 0 ), Quaternion.identity );
			}
		}
	}
	
	void OnGUI ()
	{
		GUI.backgroundColor = Color.cyan;
		GUI.contentColor = Color.white;
		
		if(GUI.Button(new Rect (Screen.width / 7 - myButtonWidth / 7,  Screen.height / 4.0f - myButtonHeight / 4.0f, myButtonWidth, myButtonHeight), "Party 1"))
		{
			Application.LoadLevel("SubPartyScreen");
		}
		
		if(GUI.Button(new Rect (Screen.width / 7 - myButtonWidth / 7,  Screen.height / 1.1f - myButtonHeight / 1.1f, myButtonWidth, myButtonHeight), "Back"))
		{
			Application.LoadLevel("PartyScreen");
		}
	}
}


