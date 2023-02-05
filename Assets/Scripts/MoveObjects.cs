using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MoveObjects : MonoBehaviour
{
    [SerializeField] private GameObject[] objects;
    [SerializeField] private Material[] mats;
    [SerializeField] private float rotSpeed = 0.1f;
    [SerializeField] private Text MatText;
    private int index = 0;
    void Update()
    {
        transform.rotation *= Quaternion.Euler(0f, rotSpeed, 0f);

        if (Input.GetKeyDown(KeyCode.G)) SetMat(mats[index--]);
        if (Input.GetKeyDown(KeyCode.H)) SetMat(mats[index++]);
        if (index >= mats.Length) index = 0;
        if (index < 0) index = mats.Length - 1;
        MatText.text = "Current Mat: " + objects[0].GetComponent<MeshRenderer>().material.name;
    }

    private void SetMat(Material mat)
    {
        for (int i=0;i<objects.Length;i++)
        {
            objects[i].GetComponent<MeshRenderer>().material = mat;
        }
    }
}
