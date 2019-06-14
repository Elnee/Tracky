public class Tracky.App : Gtk.Application {
	public App() {
		application_id = Config.APPLICATION_ID;
		flags |= ApplicationFlags.FLAGS_NONE;

		Notify.init("Tracky");
		register();
	}

	public static int main() {
		var app = new App();
		var model = new MainModel();

		app.activate.connect (() => {
			var win = app.active_window;
			if (win == null) {
				win = new Tracky.Window (app, model);
			}
			win.present ();
		});

		app.shutdown.connect (() => {
			model.saveAllTasks();
		});

		return app.run();
	}
}
