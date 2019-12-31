using Gee;

public class Tracky.MainModel : Object {
    private Database db;
    private ArrayList<Tracky.Task> tasks;
    public int nTasks { get {return tasks.size;} }

    public MainModel() {
        db = Database.getDatabase();
        tasks = db.retrieveTasks();
    }

    public string getTaskTitle(int index)
        requires (index >= 0 && index < nTasks)
    {
        return tasks[index].title;
    }

    public int getTaskCurrent(int index)
        requires (index >= 0 && index < nTasks)
    {
        return tasks[index].current;
    }

    public int getTaskGoal(int index)
        requires (index >= 0 && index < nTasks)
    {
        Tracky.Task task = tasks[index];
        if (task is Tracky.TaskGoal) return (task as Tracky.TaskGoal).goal;
        else return 0;
    }

    public bool taskHasGoal(int index)
        requires (index >= 0 && index < nTasks)
    {
        if (tasks[index] is TaskGoal) return true;
        else return false;
    }

    public void startTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        Tracky.Task task = tasks[index];
        if (task is Tracky.TaskGoal) (task as Tracky.TaskGoal).start();
        else task.start();
    }

    public void stopTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        var task = tasks[index];
        task.stop();
        db.updateTask(task);
    }

    public void resetTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        var task = tasks[index];
        task.reset();
        db.updateTask(task);
    }

    public void removeTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        db.deleteTask(tasks[index].id);
    }

    public Tracky.Task getTask(int index)
        requires (index >= 0 && index < nTasks)
    {
        return tasks[index];
    }

    public void addNewTask(string title, int goal) {
        db.createTask(title, goal);
        tasks.add(db.retrieveTasks().last());
    }

    public void saveAllTasks() {
        for (int i = 0; i < nTasks; ++i) {
            db.updateTask(tasks[i]);
        }
    }
}

