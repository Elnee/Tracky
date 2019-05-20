namespace Tracky {
	public class TaskGoalWidget : TaskWidget {
		protected Gtk.ProgressBar progress_bar;
		protected Gtk.Label goal_label;

		protected int goal;

		public TaskGoalWidget(int task_index, MainModel model) {
			base(task_index, model);

			goal = model.getTaskGoal(task_index);
			buildProgressBar();
			buildGoalLabel();

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

		protected void buildGoalLabel() {
			this.goal_label = new Gtk.Label(Helper.secondsToText(goal));
			this.goal_label.visible = true;
			this.goal_label.margin_end = 5;
			this.goal_label.xalign = 1;
			this.goal_label.hexpand = true;
			body_box.add(goal_label);
		}
	}
}
