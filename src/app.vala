namespace Tracky {
	public class App : Gtk.Application {
		public App() {
			application_id = Config.APPLICATION_ID;
			flags |= ApplicationFlags.FLAGS_NONE;

			Notify.init("Tracky");
		}

		public static int main() {
			var app = new App();

			app.activate.connect (() => {
				var win = app.active_window;
				if (win == null) {
					var model = new MainModel();
					win = new Tracky.Window (app, model);
				}
				win.present ();
			});

			return app.run();

			// Testing
			//var loop = new GLib.MainLoop ();
			//var db = new Database();
			//var tasks = db.retrieveTasks();

			//(tasks[4] as TaskGoal).finish.connect(() => {
				//db.updateTask(tasks[4]);
				//loop.quit();
			//});

			//(tasks[4] as TaskGoal).start();

			//loop.run();

			//return 0;
		}
	}
}
