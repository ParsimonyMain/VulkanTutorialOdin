package main

import "core:fmt"
import "core:os"
import "vendor:glfw"

Context :: struct {
	window: Window,
}

Window :: struct {
	handle: glfw.WindowHandle,
	width:  int,
	height: int,
}

main :: proc() {
	using ctx: Context
	init_window(&ctx)
	create_graphics_pipeline(&ctx, "simple_shader.vert", "simple_shader.frag")

	for !glfw.WindowShouldClose(window.handle) {
		glfw.PollEvents()
	}

	deinit_window(&ctx)
}

init_window :: proc(using ctx: ^Context) {
	glfw.Init()

	glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
	glfw.WindowHint(glfw.RESIZABLE, 1)
	window.width = 800
	window.height = 600
	window.handle = glfw.CreateWindow(
		cast(i32)window.width,
		cast(i32)window.height,
		"Vulkan Window",
		nil,
		nil,
	)
}

create_graphics_pipeline :: proc(using ctx: ^Context, vs_name: string, fs_name: string) {
	vs_code := compile_shader(vs_name)
	fmt.println("vert len: ", len(vs_code))
	fs_code := compile_shader(fs_name)
	fmt.println("frag len: ", len(fs_code))
	defer 
	{
		delete(vs_code)
		delete(fs_code)
	}
}

compile_shader :: proc(name: string) -> []u8 {
	src_path := fmt.tprintf("./shaders/%s", name)
	cmp_path := fmt.tprintf("./shaders/compiled/%s.spv", name)
	code, _ := os.read_entire_file(cmp_path)
	return code
}


deinit_window :: proc(using ctx: ^Context) {
	glfw.DestroyWindow(window.handle)
	glfw.Terminate()
}
