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
				var task = model.getTask(i);
				var task_widget = new TaskWidget(task.title, secondsToText(task.current));
				tasks_listbox.add(task_widget);
			}
		}

		private string secondsToText(int seconds) {
			string result = "";

			int s_in_m = 60;
			int s_in_h = 60 * s_in_m;
			int s_in_d = 24 * s_in_h;

			int days = seconds / s_in_d;
			seconds %= s_in_d;
			int hours = seconds / s_in_h;
			seconds %= s_in_h;
			int minutes = seconds / s_in_m;
			seconds %= s_in_m;

			if (days != 0) result += @"$(days)d ";
			if (hours != 0) result += @"$(hours)h ";
			if (minutes != 0) result += @"$(minutes)m ";
			if (seconds != 0) result += @"$(seconds)s ";

			return result;
		}
	}
}
