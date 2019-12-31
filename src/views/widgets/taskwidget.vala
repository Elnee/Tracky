[GtkTemplate (ui = "/com/github/Elnee/Tracky/views/ui/taskwidget.ui")]
public class Tracky.TaskWidget : Gtk.ListBoxRow {
    [GtkChild]
    protected Gtk.Label title_label;
    [GtkChild]
    protected Gtk.Button start_btn;
    [GtkChild]
    protected Gtk.Label current_label;
    [GtkChild]
    protected Gtk.Box body_box;
    [GtkChild]
    protected Gtk.Box main_box;
    [GtkChild]
    protected Gtk.Revealer controls_revealer;

    protected Gtk.Image start_icon;
    protected Gtk.Image pause_icon;
    protected bool counting;

    protected MainModel model;
    protected Tracky.Task task;

    protected bool controls_visible;

    public TaskWidget(Tracky.Task task, MainModel model) {
        this.selectable = false;

        start_icon = new Gtk.Image.from_icon_name
          ("media-playback-start", Gtk.IconSize.BUTTON);
        pause_icon = new Gtk.Image.from_icon_name
          ("media-playback-pause", Gtk.IconSize.BUTTON);

        this.model = model;
        this.task = task;

        this.title_label.label = task.title;
        this.start_btn.image = start_icon;
        this.controls_visible = false;
        this.counting = false;
        this.current_label.label = Helper.secondsToText(task.current);

        task.notify["current"].connect(() => {
            this.current_label.label = Helper.secondsToText(task.current);
        });
    }

    [GtkCallback]
    protected void on_start_btn_clicked() {
        if (!counting) {
            counting = true;
            this.start_btn.image = pause_icon;

            // FIXME: I have to get rid of these type checkings
            if (task is Tracky.TaskGoal) {
                (task as Tracky.TaskGoal).start();
            } else {
                task.start();
            }
        } else {
            counting = false;
            this.start_btn.image = start_icon;
            task.stop();
        }
    }

    [GtkCallback]
    protected void on_reset_btn_clicked() {
        counting = false;
        this.start_btn.image = start_icon;
        this.start_btn.sensitive = true;
        task.reset();
        toggleControls();
    }

    [GtkCallback]
    protected void on_remove_btn_clicked() {
        counting = false;
        task.stop();
        model.removeTask(task);
        destroy();
        base.destroy();
    }

    public void toggleControls() {
        bool show_controls = controls_visible ? false : true;
        controls_revealer.set_reveal_child(show_controls);
        controls_visible = show_controls;
    }

}
