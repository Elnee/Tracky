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

		private GLib.Timer timer;

		public Task(int id, string title, int current) {
			this.id = id;
			this.title = title;
			this.current = current;

			this.timer = new Timer();
		}

		public void start() {
			timer.start();
		}

		public void stop() {
			timer.stop();
			current += (int) timer.elapsed();
		}
	}
}
