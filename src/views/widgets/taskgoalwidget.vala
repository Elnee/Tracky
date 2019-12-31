public class Tracky.TaskGoalWidget : TaskWidget {
    protected Gtk.ProgressBar progress_bar;
    protected Gtk.Label goal_label;

    protected int goal {
        get { return ((Tracky.TaskGoal) task).goal; }
    }

    public TaskGoalWidget(Tracky.Task task, MainModel model) {
        base(task, model);

        buildProgressBar();
        buildGoalLabel();

        task.notify["current"].connect(() => {
            this.progress_bar.fraction = (double) task.current / goal;
        });

        (task as Tracky.TaskGoal).finish.connect(() => {
            this.start_btn.image = start_icon;
            this.start_btn.sensitive = false;

            try {
                var notification = new Notify.Notification(title_label.label,
                    "The task has been finished", "dialog-information");
                notification.show();
            } catch (Error e) {
                stdout.printf("Libnotify error %d: %s", e.code, e.message);
            }
        });
    }

    private void buildProgressBar() {
        this.progress_bar = new Gtk.ProgressBar();
        this.progress_bar.fraction = (double) task.current / goal;
        this.progress_bar.visible = true;
        this.progress_bar.margin_start = 5;
        main_box.add(progress_bar);
        main_box.reorder_child(progress_bar, 2);
    }

    private void buildGoalLabel() {
        this.goal_label = new Gtk.Label(Helper.secondsToText(goal));
        this.goal_label.visible = true;
        this.goal_label.margin_end = 5;
        this.goal_label.xalign = 1;
        this.goal_label.hexpand = true;
        body_box.add(goal_label);
    }
}
