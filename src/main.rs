use std::usize;

use minifb::{ScaleMode, Window, WindowOptions};

const WIDTH: usize = 1280 / 2;
const HEIGHT: usize = 640 / 2;

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

    // let mut buffer : Vec<u32> = vec![0; 1280 * 640];
   loop {
        window.update();
    }
}
