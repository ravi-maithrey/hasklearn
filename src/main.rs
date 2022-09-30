use std::f64::{sqrt, powf};
use minifb::{ScaleMode, Window, WindowOptions};

const WIDTH: usize = 1280 / 2;
const HEIGHT: usize = 640 / 2;

struct Body {
    mass: u64,
    x: i64,
    y: i64,
}

struct Force {
    magnitude: u64,
    x: i64,
    y: i64,
}

fn gravitational_force(body1: Body, body2: Body) -> Force {
    Force {
        magnitude: body1.mass * body2.mass
            / sqrt((body1.x - body2.x).powf(2.0) + (body1.y - body2.y).powf(2.0)),
        x: (body1.x - body2.x).max(body2.x - body1.x),
        y: (body1.y - body2.y).max(body2.y - body1.y),
    }
}

fn main() {
    let mut window = Window::new(
        "TestWIndow",
        WIDTH,
        HEIGHT,
        WindowOptions {
            resize: true,
            scale_mode: ScaleMode::UpperLeft,
            ..WindowOptions::default()
        },
    )
    .expect("Unable to create window");
    window.limit_update_rate(Some(std::time::Duration::from_micros(16600)));

    // let mut buffer : Vec<u64> = vec![0; 1280 * 640];
    loop {
        window.update();
    }
}
