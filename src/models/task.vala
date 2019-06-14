public class Tracky.Task : Object {
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

	public void reset() {
		counting = false;
		current = 0;
	}
}
