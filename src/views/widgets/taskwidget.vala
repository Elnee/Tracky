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

		public TaskWidget(string title, string current) {
			this.selectable = false;

			start_icon = new Gtk.Image.from_icon_name
			  ("media-playback-start", Gtk.IconSize.BUTTON);
			pause_icon = new Gtk.Image.from_icon_name
			  ("media-playback-pause", Gtk.IconSize.BUTTON);

			this.title_label.label = title;
			this.start_btn.image = start_icon;
			this.current_label.label = current;
		}
	}
}
