namespace Tracky {
	public class Config : Object {
		private string _home_config;

		public const string APPLICATION_ID = "com.github.Elnee.Tracky";
		public string HOME_CONFIG {
			get { return _home_config; }
		}

		public Config() {
			_home_config = GLib.Environment.get_home_dir() + "/.config/Tracky/";
		}
	}
}
