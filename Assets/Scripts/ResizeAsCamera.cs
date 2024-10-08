using UnityEngine;

public class ResizeAsCamera : MonoBehaviour
{
    void Awake()
    {
        Camera cam = Camera.main;
        float height = 2f * cam.orthographicSize;
        float width = height * cam.aspect;

        transform.localScale = new Vector3(width, height, 1f);
        transform.position = cam.transform.position + cam.transform.forward * (cam.nearClipPlane + .01f);
    }
}
