namespace Tracky {
	public interface iTask : Object {
		public abstract int id { get; protected set; }
		public abstract string title { get; protected set; }
		public abstract int current { get; protected set; }

		public abstract void start();
		public abstract void stop();
	}

	public class Task : Object, iTask {
		public int id { get; protected set; }
		public string title { get; protected set;}
		public int current { get; protected set; }

		protected bool counting;

		public Task(int id, string title, int current) {
			this.id = id;
			this.title = title;
			this.current = current;
			this.counting = false;
		}

		public void start() {
			counting = true;
			GLib.Timeout.add_seconds(1, () => {
				if (!counting) return false;
				current += 1;
				return true;
			});
		}

		public void stop() {
			counting = false;
		}
	}
}
