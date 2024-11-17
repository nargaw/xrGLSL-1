varying vec2 vUv;
uniform float u_time;
uniform vec2 u_resolution;

//circle function
//takes the value of a point and draws a radius r distance away
float sdCircle(vec2 p, float r)
{
    return length(p) - r;
}

float rand(float x){
        return fract(sin(x)* 1e4);
    }
    
    float plot(vec2 vUv, float pct){
        return smoothstep(pct - 0.05, pct, vUv.x) - 
               smoothstep(pct, pct + 0.05, vUv.x);
    }

float rect( vec2 vUv, float height, float width)
{
    float left = smoothstep(((1.0 - width)/ 2.0), ((1.0 - width)/ 2.0) + 0.001, vUv.x);
    float right = smoothstep(((1.0 - width)/2.0), ((1.0 - width)/ 2.0) + 0.001, 1. - vUv.x);
    float top = smoothstep(((1.0 - height)/2.0), ((1.0 - height)/2.0) + 0.001, 1. - vUv.y);
    float bottom = smoothstep(((1.0 - height)/2.0), ((1.0 - height)/2.0) + 0.001, vUv.y);
    // return left * right * top * bottom;
    float x = left * right * top * bottom;
    // float y = x ;
    return x;
}

    void main()
    {
        vec2 coords = vUv;
        vec2 numCoords = coords;
        vec2 lineCoords = coords;
        lineCoords *= 5. - 2.5;
        lineCoords.x -= 1.;
        lineCoords.x *= 2.5;
        lineCoords.y -= u_time;
        // coords.y -= u_time;
        vec3 color;
        float line;
        float cir;
        float box = rect(vec2(coords.x, coords.y - 0.4), 0.8, 1.2);
        for(int k = 0; k <= 10; k ++){
            float i = floor(lineCoords.y + float(k) * 10.);
            float f = fract(lineCoords.y + float(k) * 10.);
            float x = rand(i + (u_time * 0.00002));
            x = pow(x, 2.);
            float y = rand(i + (u_time * 0.00002) + 1.);
            y = pow(y, 2.);
            x = mix(x, y, smoothstep(0., 1., f ));
            line += plot(lineCoords, x);
            // color = line * vec3((float(k)/15.), 0.5, float(k)/10.);
            cir = 1.0 / length(vec2((coords.x - 0.5), coords.y - 0.5));
            cir *= 0.05;
            cir = pow(cir, 0.8);
        }
        
        // cir = pow(cir, 200.);
        // color += box * vec3(1., 0., 0.);
        color = mix(color, vec3(0.), box);
        color = mix(color, vec3(1., 0.5, 0.25), cir * line);


    //the final color is sent to the gl_FragColor and will be drawn on the screen
    gl_FragColor = vec4(color, 1.);
}