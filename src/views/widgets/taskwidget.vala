namespace Tracky {
	[GtkTemplate (ui = "/com/github/Elnee/Tracky/views/ui/taskwidget.ui")]
	public class TaskWidget : Gtk.ListBoxRow {
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
		protected int current;

		protected MainModel model;
		protected int task_index;
		protected bool show_controls;

		public TaskWidget(int task_index, MainModel model) {
			this.selectable = false;

			start_icon = new Gtk.Image.from_icon_name
			  ("media-playback-start", Gtk.IconSize.BUTTON);
			pause_icon = new Gtk.Image.from_icon_name
			  ("media-playback-pause", Gtk.IconSize.BUTTON);

			this.model = model;
			this.task_index = task_index;

			this.title_label.label = model.getTaskTitle(task_index);
			this.start_btn.image = start_icon;
			this.show_controls = false;
			this.counting = false;
			this.current = model.getTaskCurrent(task_index);
			this.current_label.label = Helper.secondsToText(current);

			model.getTask(task_index).notify["current"].connect(() => {
				this.current = model.getTaskCurrent(task_index);
				this.current_label.label =
					Helper.secondsToText(this.current);
			});
		}

		[GtkCallback]
		protected void on_start_btn_clicked() {
			if (!counting) {
				counting = true;
				this.start_btn.image = pause_icon;
				model.startTask(task_index);
			} else {
				counting = false;
				this.start_btn.image = start_icon;
				model.stopTask(task_index);
			}
		}

		[GtkCallback]
		protected void on_reset_btn_clicked() {
			counting = false;
			this.start_btn.image = start_icon;
			this.start_btn.sensitive = true;
			model.resetTask(task_index);
			toggleControls();
		}

		[GtkCallback]
		protected void on_remove_btn_clicked() {
			counting = false;
			model.stopTask(task_index);
			model.removeTask(task_index);
			destroy();
			base.destroy();
		}

		public void toggleControls() {
			if (show_controls) {
				controls_revealer.set_reveal_child(false);
				show_controls = false;
			} else {
				controls_revealer.set_reveal_child(true);
				show_controls = true;
			}
		}

	}
}
