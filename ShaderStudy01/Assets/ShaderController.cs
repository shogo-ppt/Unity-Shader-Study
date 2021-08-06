using System.Collections;
using UnityEngine;

public class ShaderController : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        GetComponent<Renderer> ().material.SetColor ("_BaseColor", Color.black);
    }
}
