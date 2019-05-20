namespace Tracky {
	public class TaskGoalWidget : TaskWidget {
		protected Gtk.ProgressBar progress_bar;

		protected int goal;

		public TaskGoalWidget(int task_index, MainModel model) {
			base(task_index, model);

			goal = model.getTaskGoal(task_index);
			buildProgressBar();

			var task = model.getTask(task_index);
			(task as Tracky.TaskGoal).notify["current"].connect(() => {
				this.progress_bar.fraction = (double) current / goal;
			});
		}

		protected void buildProgressBar() {
			this.progress_bar = new Gtk.ProgressBar();
			this.progress_bar.fraction = (double) current / goal;
			this.progress_bar.visible = true;
			this.progress_bar.margin_start = 5;
			main_box.add(progress_bar);
		}
	}
}
