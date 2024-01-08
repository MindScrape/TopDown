/// @description Step event.
if (active) {
	scr_dialog_load(player)
} else if (!active and canBeginConvo) {
	show_debug_message("DIALOG CAN START!")
	active = true
	convo_test1(player) // Let's make this a bit more dynamic...
}
