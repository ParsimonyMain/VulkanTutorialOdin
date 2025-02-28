package main

import "core:fmt"
import "vendor:glfw"

Context :: struct {
	window: Window,
}

Window :: struct {
	handle: glfw.WindowHandle,
	width:  int,
	height: int,
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

main :: proc() {
	using ctx: Context
	init_window(&ctx)

	for !glfw.WindowShouldClose(window.handle) {
		glfw.PollEvents()
	}

	// defers will execute in reverse order
	defer glfw.Terminate()
	defer glfw.DestroyWindow(window.handle)
}
