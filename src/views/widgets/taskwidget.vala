namespace Tracky {
	[GtkTemplate (ui = "/com/github/Elnee/Tracky/views/ui/taskwidget.ui")]
	public class TaskWidget : Gtk.ListBoxRow {
		[GtkChild]
		private Gtk.Label title_label;
		[GtkChild]
		private Gtk.Button start_btn;
		[GtkChild]
		public Gtk.Label current_label;

		private Gtk.Image start_icon;
		private Gtk.Image pause_icon;
		private bool counting = false;
		private int seconds;

		public TaskWidget(int task_index, MainModel model) {
			this.selectable = false;

			start_icon = new Gtk.Image.from_icon_name
			  ("media-playback-start", Gtk.IconSize.BUTTON);
			pause_icon = new Gtk.Image.from_icon_name
			  ("media-playback-pause", Gtk.IconSize.BUTTON);

			this.title_label.label = model.getTaskTitle(task_index);
			this.start_btn.image = start_icon;
			this.seconds = model.getTaskCurrent(task_index);
			this.current_label.label = Helper.secondsToText(seconds);
		}

		[GtkCallback]
		private void on_start_btn_clicked() {
			if (!counting) {
				this.start_btn.image = pause_icon;
				counting = true;
			} else {
				this.start_btn.image = start_icon;
				counting = false;
			}
		}
	}
}
