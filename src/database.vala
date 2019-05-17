namespace Tracky {
	public class Database : Object {
		private Sqlite.Database db;
		private const string DB_NAME = "main.db";
		private Tracky.Config conf = new Config();
		private string errmsg;

		//TODO: Handle errors
		public Database() {
			// Checking if database exists and open if exists
			File db_file = File.new_for_path(conf.HOME_CONFIG + DB_NAME);
			if (db_file.query_exists()) {
				int ec = Sqlite.Database.open (conf.HOME_CONFIG + DB_NAME, out db);
				if (ec != Sqlite.OK)
					stderr.printf("Can't open database: %d: %s\n", db.errcode(), db.errmsg());
			} else {
				// Create new DB file if doesn't exist one
				stdout.printf("Will create a new database\n");

				// Ensure that home config directories exist
				File conf_path = File.new_for_path(conf.HOME_CONFIG);
				if (!conf_path.query_exists())
					conf_path.make_directory_with_parents();

				Sqlite.Database.open_v2 (conf.HOME_CONFIG + DB_NAME, out db,
					Sqlite.OPEN_READWRITE | Sqlite.OPEN_CREATE);

				// Create new table
				string query = """
					CREATE TABLE Cards (
						id      INT  PRIMARY KEY         ,
						title   TEXT             NOT NULL,
						current INT              NOT NULL,
						goal    INT
					);
				""";

				int ec = db.exec(query, null, out errmsg);
				if (ec != Sqlite.OK) {
					stderr.printf("Database error: %s\n", errmsg);
				}
			}
		}
	}
}
