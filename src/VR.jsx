import { useFrame } from "@react-three/fiber"
import { useRef } from "react"
import * as THREE from 'three'
import vertex from './shaders/vertex.glsl'
import fragment from './shaders/fragment.glsl'

export default function VR()
{
  const overlayMaterial = new THREE.ShaderMaterial({
      uniforms: 
      {
          u_time: { value: new THREE.Uniform(0)},
          u_resolution: {value: new THREE.Uniform(new THREE.Vector2()) },
      },
      vertexShader: vertex,
      fragmentShader: fragment,
      side: THREE.DoubleSide
  })

  const DPR = Math.min(window.devicePixelRatio, 1.);

  useFrame(({clock}) => {
    meshRef.current.material.uniforms.u_time.value = clock.elapsedTime
    meshRef.current.material.uniforms.u_resolution.value = new THREE.Vector2(
        window.innerWidth * DPR,
        window.innerHeight * DPR
    )

  })

  const meshRef = useRef()

    return <>
        <mesh ref={meshRef} pointerEventsType={{deny: 'grab'}} onClick={() => setRed(!red)} position={[0, 1, -2]} material={overlayMaterial} rotation={[0, 0, 0]}>
            <planeGeometry args={[2 * DPR, 2 * DPR]}/>
            {/* <meshBasicMaterial color={red ? 'red' : 'green'}/> */}
        </mesh>
    </>
}