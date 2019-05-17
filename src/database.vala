namespace Tracky {
	public class Database : Object {
		private Sqlite.Database db;
		private const string DB_NAME = "main.db";
		private Tracky.Config conf = new Config();

		public Database() {
			int ec = Sqlite.Database.open (conf.HOME_CONFIG + DB_NAME, out db);
			if (ec != Sqlite.OK) {
				stderr.printf("Can't open database: %d: %s\n", db.errcode(), db.errmsg());
				stdout.printf("Will create a new database");
				File db_file = File.new_for_path(conf.HOME_CONFIG);
				db_file.make_directory_with_parents();

				Sqlite.Database.open_v2 (conf.HOME_CONFIG + DB_NAME, out db, Sqlite.OPEN_READWRITE |
					Sqlite.OPEN_CREATE);

				// Create table
				string query = """
					CREATE TABLE Cards (
						id      INT  PRIMARY KEY NOT NULL,
						title   TEXT             NOT NULL,
						current INT              NOT NULL,
						remain  INT
					);

					INSERT INTO Cards (id, title, current, remain) VALUES (1, 'Some', 423424, NULL);
				""";
			}
		}
	}
}
