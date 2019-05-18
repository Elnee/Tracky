using Gee;

namespace Tracky {
	public class Database : Object {
		private Sqlite.Database db;
		private const string DB_NAME = "main.db";
		private Tracky.Config conf = new Config();
		private string errmsg;

		public Database() {
			// Checking if database exists and open if exists
			File db_file = File.new_for_path(conf.HOME_CONFIG + DB_NAME);
			if (db_file.query_exists()) {
				int ec = Sqlite.Database.open (conf.HOME_CONFIG + DB_NAME, out db);
				if (ec != Sqlite.OK)
					stderr.printf("Can't open database %d: %s\n", db.errcode(), db.errmsg());
			} else {
				// Create new DB file if doesn't exist one
				stdout.printf("Will create a new database\n");

				// Ensure that home config directories exist
				File conf_path = File.new_for_path(conf.HOME_CONFIG);
				if (!conf_path.query_exists()) {
					try {
						conf_path.make_directory_with_parents();
					} catch (Error e) {
						stdout.printf("GIO Error %d: %s\n", e.code, e.message);
					}
				}

				Sqlite.Database.open_v2 (conf.HOME_CONFIG + DB_NAME, out db,
					Sqlite.OPEN_READWRITE | Sqlite.OPEN_CREATE);

				// Create new table
				string query = """
					CREATE TABLE Cards (
						id      INTEGER  PRIMARY KEY     ,
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

		public ArrayList<Task> retrieveTasks() {
			Sqlite.Statement stmt;
			var tasks = new ArrayList<Task>();
			const string RETRIEVE_TASKS = "SELECT * FROM Cards;";

			int ec = db.prepare_v2(RETRIEVE_TASKS, RETRIEVE_TASKS.length, out stmt);
			if (ec != Sqlite.OK)
				stderr.printf("Error %d: %s\n", db.errcode(), db.errmsg());

			while (stmt.step() == Sqlite.ROW) {
				int task_id = stmt.column_value(0).to_int();
				string task_title = stmt.column_value(1).to_text();
				int task_current = stmt.column_value(2).to_int();
				int task_goal = stmt.column_value(3).to_int();

				if (task_goal == 0) tasks.add(new Task(task_id, task_title, task_current));
				else tasks.add(new TaskGoal(task_id, task_title, task_current, task_goal));
			}

			return tasks;
		}

		public void updateTask (Task task) {
			string task_goal = (task is TaskGoal) ? (task as TaskGoal).goal.to_string() : "NULL";

			string query = @"UPDATE Cards SET title='$(task.title)', " +
			               @"current=$(task.current), " +
			               @"goal=$(task_goal) WHERE id=$(task.id)";

			int ec = db.exec(query, null, out errmsg);
			if (ec != Sqlite.OK)
				stderr.printf ("Error: %s\n", errmsg);
		}

	}
}
