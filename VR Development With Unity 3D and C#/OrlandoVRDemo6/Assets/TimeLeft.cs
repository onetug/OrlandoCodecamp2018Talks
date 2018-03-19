using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TimeLeft : MonoBehaviour {

    public float timeToPlay = 40;
    public Text timeLeft;


	void FixedUpdate () {
        timeToPlay -= Time.fixedDeltaTime;
        timeLeft.text = timeToPlay.ToString("0.0");
        if (timeToPlay < 0)
        {
            Time.timeScale = 0;

        }
		
	}
}
