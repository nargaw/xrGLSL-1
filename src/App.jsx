import { Canvas } from "@react-three/fiber"
import { XR, createXRStore } from '@react-three/xr'
import VR from "./VR"

const store = createXRStore()

function App() {
  
  return (
    <>
      <botton className={'button'} onClick={() => store.enterVR()}>Enter VR</botton>
      <Canvas>
        <XR store={store}>
          <VR />
        </XR>
      </Canvas>
    </>
  )
}

export default App
