using Gee;

public class Tracky.MainModel : Object {
    private Database db;
    private ArrayList<Tracky.iTask> tasks;
    public int nTasks { get {return tasks.size;} }

    public MainModel() {
        db = Database.getDatabase();
        tasks = db.retrieveTasks();
    }

    public Tracky.iTask getTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        return tasks[index];
    }

    public Tracky.iTask addNewTask(string title, int goal) {
        db.createTask(title, goal);
        tasks.add(db.retrieveTasks().last());
        return tasks.last();
    }

    public void removeTask(Tracky.iTask task) {
        db.deleteTask(task.id);
    }

    public void saveAllTasks() {
        for (int i = 0; i < nTasks; ++i) {
            db.updateTask(tasks[i]);
        }
    }
}

