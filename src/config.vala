namespace Tracky {
	public class Config : Object {
		public const string APPLICATION_ID = "com.github.Elnee.Tracky";
		public string HOME_CONFIG {
			get { return _home_config; }
		}

		private string _home_config;

		private static Config? instance;

		public static Config getConfig() {
			if (instance == null) {
				instance = new Config();
			}
			return instance;
		}

		private Config() {
			_home_config = GLib.Environment.get_home_dir() + "/.config/Tracky/";
		}
	}
}
