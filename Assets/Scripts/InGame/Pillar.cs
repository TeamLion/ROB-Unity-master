using UnityEngine;
using System.Collections;
using System.Text.RegularExpressions;
using System;

public class Pillar : MonoBehaviour {
	
	public static int hitPoints;
	public float SleepVelocity;
	public static GameObject objectToDestroy;
	
	public ParticleSystem onHit;
		
	void Start () {
		
		SleepVelocity = 0.1f;
		string levelName = Application.loadedLevelName;
		var digitMatch = Regex.Match(levelName, @"\d+");
		int levelStrength = Convert.ToInt32(digitMatch.Groups[0].Value);
		
		if(levelStrength <= 2)
		{
			hitPoints = 0;
		}
		
		else if(levelStrength > 2 && levelStrength <= 6)
		{
			hitPoints = 2;
		}
		
		else if(levelStrength > 6)
		{
			hitPoints = 4;
		}
	}
	
	void OnCollisionEnter(Collision collision)
	{
		onHit.Play();
		
		foreach (ContactPoint point in collision.contacts) 
		{
			
			if(collision.gameObject.tag.Equals("Player"))
			{
				
				if(hitPoints > 0)
				{
					hitPoints -= 1;
					Debug.Log("HP DMG: " + hitPoints);
				}
				
				else if(hitPoints == 0)
				{
				    objectToDestroy = this.gameObject;
				}
			}
		}
	}
}
