/* window.vala
 *
 * Copyright 2019 Elnee
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Tracky {
	[GtkTemplate (ui = "/com/github/Elnee/Tracky/views/ui/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
		private Gtk.ListBox tasks_listbox;

		private MainModel model;

		public Window (Gtk.Application app, MainModel model) {
			this.application = app;
			this.model = model;

			drawTasks();
		}

		private void drawTasks() {
			for (int i = 0; i < model.nTasks; ++i) {
				TaskWidget task_widget;
				if (!model.taskHasGoal(i))
					task_widget = new TaskWidget(i, model);
				else
					task_widget = new TaskGoalWidget(i, model);
				tasks_listbox.add(task_widget);
			}
		}

	}
}
