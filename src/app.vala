namespace Tracky {
	public class App : Gtk.Application {
		public App() {
			application_id = Config.APPLICATION_ID;
			flags |= ApplicationFlags.FLAGS_NONE;
		}

		public static int main() {
			var app = new App();

			app.activate.connect (() => {
				var win = app.active_window;
				if (win == null) {
					win = new Tracky.Window (app);
				}
				win.present ();
			});

			return app.run();
		}
	}
}
