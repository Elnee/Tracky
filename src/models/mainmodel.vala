using Gee;

public class Tracky.MainModel : Object {
    private Database db;
    private ArrayList<Tracky.Task> tasks;
    public int nTasks { get {return tasks.size;} }

    public MainModel() {
        db = Database.getDatabase();
        tasks = db.retrieveTasks();
    }

    public Tracky.Task getTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        return tasks[index];
    }

    public Tracky.Task addNewTask(string title, int goal) {
        db.createTask(title, goal);
        tasks.add(db.retrieveTasks().last());
        return tasks.last();
    }

    public void saveAllTasks() {
        for (int i = 0; i < nTasks; ++i) {
            db.updateTask(tasks[i]);
        }
    }
}

