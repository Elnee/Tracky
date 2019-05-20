namespace Tracky {
	public class TaskGoalWidget : TaskWidget {
		protected Gtk.ProgressBar progress_bar;

		public TaskGoalWidget(int task_index, MainModel model) {
			base(task_index, model);
			this.progress_bar = new Gtk.ProgressBar();
			this.progress_bar.fraction = 0.5;
			this.progress_bar.visible = true;

			body_box.add(progress_bar);
		}
	}
}
