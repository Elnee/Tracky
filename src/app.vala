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
			var taskgoal = new TaskGoal(1, "Fffff", 0, 2);
			taskgoal.finish.connect(() => {
				stdout.printf("COMPLETE!\n");
			});
			taskgoal.start();

			while (!taskgoal.finished) {
				stdout.printf("%d", taskgoal.current);
			}

			return 0;
		}
	}
}
