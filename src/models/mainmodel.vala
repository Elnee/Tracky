using Gee;

namespace Tracky {
	public interface iMainModel : Object {
		public abstract Tracky.Task getTask(int id);
		public abstract int nTasks { get; }
	}

	public class MainModel : Object, iMainModel {
		private Database db;
		private ArrayList<Tracky.Task> tasks;
		public int nTasks { get {return tasks.size;} }

		public MainModel() {
			db = new Database();
			tasks = db.retrieveTasks();
		}

		public Tracky.Task getTask(int id) {
			return tasks[id];
		}

	}
}
