using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Models : MonoBehaviour
{
    [SerializeField] private GameObject[] models;
    [SerializeField] private float rotSpeed= 0.1f;
    void Update()
    {
        for (int i=0;i<models.Length;i++)
        {
            models[i].transform.rotation *= Quaternion.Euler(0f, rotSpeed, 0f);
        }
    }
}
