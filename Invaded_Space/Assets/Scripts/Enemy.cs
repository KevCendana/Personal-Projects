using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/* 
    base class for all enemies, has basic functionality like movement, attacking, taking damage, dying, etc
*/  

public class Enemy : HealthSystem
{
    public float speed = 0.5f; // enemy movespeed
    public Transform target; // enemy target moves towards
    public int damage = 10; // enemy damage dealt to target

    protected virtual void Start() {
        base.Start();
        // TODO: initialization for stuff that applies to all enemies
    }

    // Update is called once per frame
    void Update()  {
        // move the enemy towards the target
        float step = speed * Time.deltaTime;                                                 // calculate distance to move
        transform.position = Vector3.MoveTowards(transform.position, target.position, step); // move the enemy
       
        // if the enemy is close enough to the target, attack (and then die)
        if (Vector3.Distance(transform.position, target.position) < 0.1f) {
            Attack();
            Die();
        }
    }

    // function for enemy to attack target
    void Attack() {
        // TODO: calculate dmg based on enemy stats and target stats, etc
        Debug.Log("enemy attacks for " + damage + " damage! oof owie"); 
    }
}