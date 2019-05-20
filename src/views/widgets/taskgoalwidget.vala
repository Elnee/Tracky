namespace Tracky {
	[GtkTemplate (ui = "/com/github/Elnee/Tracky/views/ui/taskgoalwidget.ui")]
	public class TaskGoalWidget : TaskWidget {
		public TaskGoalWidget(int task_index, MainModel model) {
			base(task_index, model);
		}
	}
}
