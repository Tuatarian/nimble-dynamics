import raylib, math, rayutils, sugar

func RungeKutta4*(f : (float) -> float, x0, dt : float) : float = ## 4th order Runge-Kutta solver for eq in the form dx/dt = f(x)
    let k1 = f(x0)*dt
    let k2 = f(x0 + k1/2)*dt
    let k3 = f(x0 + k2/2)*dt
    let k4 = f(x0 + k3)*dt
    return x0 + (k1 + 2*k2 + 2*k3 + k4)/6