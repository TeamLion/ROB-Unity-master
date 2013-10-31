using UnityEngine;
using System.Collections;

//For Andrew....

public class Grid : MonoBehaviour 
{
 
 // The object that you want to keep creating (ie. box, sphere, plane.  You can use other gameobjects when you creat them)
 public GameObject prefab;
 
 // How many objects you want to create in the X Direction and Offset
 public int m_nXAmount;
 public int m_nXOffset;
 
 // How many Objects you want to create in the Y Direction and Offset
 public int m_nYAmount;
 public int m_nYOffset;
 
 // Use this for initialization
 void Start () 
 {
  
  // Loop from 0 to How many you want in the X direction and increment by 1
  for( int x = 0; x < m_nXAmount; ++x )
  {
   // Loop from 0 to How many you want in the Y direction and increment by 1
   for( int y = 0; y < m_nYAmount; ++y )
   { 
    // Create a new GameOjbect, position of ( X, Y, - ), At the center point or "identity" of the GameObject
    Instantiate( prefab, new Vector3( x * m_nXOffset, y * m_nYOffset, 0 ), Quaternion.identity );
   }
  }
  
 }
 
 // Update is called once per frame
 void Update () 
 {
 
 }
}