namespace Tracky {
	public interface iTaskGoal : Object {
		public abstract int goal { get; protected set; }
		public abstract bool finished { get; protected set; }

		public abstract signal void finish();
	}

	public class TaskGoal : Task, iTaskGoal {
		public int goal { get; protected set; }
		public bool finished { get; protected set; }

		public TaskGoal(int id, string title, int current, int goal) {
			base(id, title, current);
			this.goal = goal;
			this.finished = (current >= goal) ? true : false;
		}

		public new async void start() {
			if (current < goal) {
				timer.start();
				while (!finished) {
					int elapsed = (int) timer.elapsed();
					if (elapsed >= goal - current) {
						timer.stop();
						current = goal;
						finished = true;
						finish();
					}
					GLib.Idle.add(this.start.callback);
					yield;
				}
			}
		}

	}
}
