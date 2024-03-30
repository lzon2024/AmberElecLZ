from subprocess import PIPE, run

def sanity_check(rom, platform, emulator, core, args):
	def show_sanity_warn( message ) :
		"""This function's sole purpose is to tell the user what we're doing and then ask for consent. If none is given, we stop here."""
		run(["text_viewer", "-m", message, "-t", "AmberELEC Sanity Checker"], stdout=PIPE, stderr=PIPE, universal_newlines=True, check=False)
		exit()

	extension = rom.suffix.lower()
	if (extension == ".pbp" and core == "duckstation" ):
		show_sanity_warn("The Duckstation core does not support .pbp files.\n\nPlease try another core for this rom!\n\nExiting...")
	if (extension == ".neo" and core != "geolith" ):
		show_sanity_warn("Only the Geolith core supports .neo files.\n\nPlease try another core for this rom!\n\nExiting...")
