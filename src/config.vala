namespace Tracky {
	public class Config {
		private string _database_location;

		public const string APPLICATION_ID = "com.github.Elnee.Tracky";
		public string DATABASE_LOCATION {
			get { return _database_location; }
		}

		public Config() {
			_database_location = GLib.Environment.get_home_dir() + "/.config/Tracky/main.db";
		}
	}
}
