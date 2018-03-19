using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AddScore : MonoBehaviour {

    private Text scoreText;

	// Use this for initialization
	void Start () {
        scoreText = GameObject.FindWithTag("Score").GetComponent<Text>();
	}

    private void OnCollisionEnter(Collision collision)
    {
        if (scoreText == null)
            return;
        var score = int.Parse(scoreText.text);
        score++;
        scoreText.text = score.ToString();
        GameObject.Destroy(this.gameObject);
    }

}
