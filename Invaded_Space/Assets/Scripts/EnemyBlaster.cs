using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/* 
    basic blaster enemy that fires projectiles at the player
*/

public class EnemyBlaster : Enemy
{
    public GameObject projectilePrefab; // for projectile prefab
    public float shootingInterval = 3f; // time interval between shots

    protected override void Start() {   
        base.Start();   // call Start method of the base Enemy class, nothing there yet tho
        InvokeRepeating("ShootProjectile", 0f, shootingInterval); // call ShootProjectile every shootingInterval seconds
    }

    // ShootProjectile is called every shootingInterval seconds
void ShootProjectile() {
    GameObject projectile = Instantiate(projectilePrefab, transform.position, Quaternion.identity); // instantiate the projectile
    Debug.Log("Projectile instantiated at " + transform.position);
    Projectile projScript = projectile.GetComponent<Projectile>();  // get the Projectile script component of the projectile
    if (projScript != null) {   // if the Projectile script component exists
        projScript.target = GameObject.Find("Player Mothership").transform; // set the target to Player Mothership
        projScript.isAllied = false; // this is an enemy projectile
    }
}

}
