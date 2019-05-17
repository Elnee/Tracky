namespace Tracky {
	public interface iTaskGoal : Object {
		public abstract int goal { get; protected set; }
		public abstract bool finished { get; protected set; default = false; }

		public abstract signal void finish();
	}

	public class TaskGoal : Task, iTaskGoal {
		public int goal { get; protected set; }
		public bool finished { get; protected set; default = false; }

		private int _current;
		public new int current {
			get {
				_current = (int) timer.elapsed();
				if (_current >= goal) {
					finish();
					finished = true;
					timer.stop();
					return _current;
				} else return _current;
			}
			protected set {
				_current = value;
			}
		}

		public TaskGoal(int id, string title, int current, int goal) {
			base(id, title, current);
			this.goal = goal;
		}

		public new void start() {
			if (current < goal)
				timer.start();
		}

		public new void stop() {
			timer.stop();
			int elapsed = (int) timer.elapsed();
			if (elapsed >= goal) {
				current = goal;
				finish();
				finished = true;
			}
			else current += elapsed;
		}
	}
}
