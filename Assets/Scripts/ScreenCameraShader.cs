using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
[ExecuteInEditMode]
public class ScreenCameraShader : MonoBehaviour
{
    //public Shader awesomeShader = null;
    [SerializeField] private Material[] mats;
    [SerializeField] private Text LutText;
    private Material m_renderMaterial;
    private int index = 0;
    private void Update()
    {
        m_renderMaterial = mats[index];
        if (Input.GetKeyDown(KeyCode.L)) m_renderMaterial = mats[index++];
        if (index >= mats.Length) index = 0;
        if (index < 0) index = mats.Length - 1;
        LutText.text = "Current LUT: " + m_renderMaterial.name;
    }
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, m_renderMaterial);
    }
}