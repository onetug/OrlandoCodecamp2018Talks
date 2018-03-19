using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KillSelfAtTime : MonoBehaviour {

    public float timeToDie = 5;
    private float timeSinceSpawn = 0;
    private float iterations = 0;

    private void FixedUpdate()
    {
        timeSinceSpawn += Time.fixedDeltaTime;
        iterations++;
        if(iterations % 8 == 0)
        {
            if (timeSinceSpawn > timeToDie)
            {
                GameObject.Destroy(this.gameObject);

            }
        }

    }

}
