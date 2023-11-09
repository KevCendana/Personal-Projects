using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


/*
    base class for everything that has health 
*/
public class HealthSystem : MonoBehaviour
{
    public int health = 100; // health of the object
    public Slider healthSlider; // health bar slider
    public TextMeshProUGUI healthText; // health bar text
    public void Start() {
        Debug.Log("Setting initial health text for: " + gameObject.name);
        if (healthText != null) {                   // if the health text exists
            healthText.text = health.ToString();    // set the health text to the health of the object
        }
    }
    public void Update() {
        // update health text and slider
        if (healthText != null) {
            healthText.text = health.ToString();
        }
        if (healthSlider != null) {
            healthSlider.value = (float)health / 100;
        }

        // position the health bar above the object (unless it's the mothership)
        if (healthSlider != null && gameObject.name != "Player Mothership") {
            healthSlider.transform.position = transform.position + new Vector3(0, 0.6f, 0);
        }
    }

    public virtual void TakeDamage(int damage) {
        health -= damage;
        if (healthSlider != null) {
            healthSlider.value = (float)health / 100; // assuming max health is 100
        }
        if (healthText != null) {
            healthText.text = health.ToString();
        }        
        if (health <= 0) {
            Die();
        }
    }

    public virtual void Die() {
        // TODO: add death animation, sound, etc here
        Destroy(gameObject);
    }
}
