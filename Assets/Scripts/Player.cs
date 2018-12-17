using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{

	public float speed = 3f;

	public Rigidbody2D rb2D;
	public Collider2D col2D;

	void Awake ()
	{
		rb2D = GetComponent<Rigidbody2D>();
		col2D = GetComponent<Collider2D>();

		if (rb2D == null) Debug.LogError("No Rigidbody2D component found attached to Player game object! [PLAYER.CS]");
		if (col2D == null) Debug.LogError("No Collider2D component found attached to Player game object! [PLAYER.CS]");
	}
	
	void Update ()
	{
		Vector3 movementVector = Vector3.zero;

		if (Input.GetKey(KeyCode.D))
		{
			movementVector += Vector3.right;
		}
		else if (Input.GetKey(KeyCode.A))
		{
			movementVector += Vector3.left;
		}

		if (Input.GetKey(KeyCode.W))
		{
			movementVector += Vector3.up;
		}
		else if (Input.GetKey(KeyCode.S))
		{
			movementVector += Vector3.down;
		}

		Debug.Log(movementVector);
	}
}
