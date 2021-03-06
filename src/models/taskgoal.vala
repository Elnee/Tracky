public class Tracky.TaskGoal : Tracky.Task, Tracky.iTask {
    public int goal { get; protected set; }
    public bool finished { get; protected set; }

    public abstract signal void finish();

    public TaskGoal(int id, string title, int current, int goal) {
        base(id, title, current);
        this.goal = goal;
        this.finished = (current >= goal) ? true : false;
    }

    public new void start() {
        counting = true;
        GLib.Timeout.add_seconds(1, () => {
            if (!counting)
                return false;

            current += 1;

            if (current == goal)
                finish();

            return true;
        });
    }
}

