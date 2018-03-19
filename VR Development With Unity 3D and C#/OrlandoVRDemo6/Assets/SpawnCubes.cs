using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnCubes : MonoBehaviour {

    private float time;
    public float timeBetweenSpawns = .5f;
    public GameObject gameObjectToSpawn;
    private float iterations = 0;
	
	void FixedUpdate () {
        time += Time.fixedDeltaTime;
        iterations++;
        if(iterations % 9 == 0)
        {
            if(time > timeBetweenSpawns)
            {
                time = 0;
                GameObject.Instantiate(gameObjectToSpawn, 
                    new Vector3(Random.Range(-1f, 1f), Random.Range(.75f, 1.75f), Random.Range(1f, 1.5f)), 
                    new Quaternion());
                timeBetweenSpawns = timeBetweenSpawns * .95f;

            }
        }

	}
}
