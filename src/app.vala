namespace Tracky {
	public class App : Gtk.Application {
		public App() {
			application_id = Config.APPLICATION_ID;
			flags |= ApplicationFlags.FLAGS_NONE;
		}

		public static int main() {
			/*var app = new App();

			app.activate.connect (() => {
				var win = app.active_window;
				if (win == null) {
					win = new Tracky.Window (app);
				}
				win.present ();
			});

			return app.run();*/

			// Testing
			GLib.MainLoop mainloop = new GLib.MainLoop();
			var taskgoal = new TaskGoal(1, "Fffff", 5, 7);
			taskgoal.finish.connect(() => {
				stdout.printf("COMPLETE 1!\n");
				stdout.printf(@"CURRENT: $(taskgoal.current)\n");
				mainloop.quit();
			});
			taskgoal.start();

			var taskgoal2 = new TaskGoal(1, "Fffff", 0, 2);
			taskgoal2.finish.connect(() => {
				stdout.printf("COMPLETE 2!\n");
				stdout.printf(@"CURRENT: $(taskgoal2.current)\n");
			});
			taskgoal2.start();

			mainloop.run();

			return 0;
		}
	}
}
