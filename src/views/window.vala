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

[GtkTemplate (ui = "/com/github/Elnee/Tracky/views/ui/window.ui")]
public class Tracky.Window : Gtk.ApplicationWindow {
    [GtkChild]
    private Gtk.ListBox tasks_listbox;
    [GtkChild]
    private Gtk.Stack main_stack;
    [GtkChild]
    private Gtk.CheckButton withgoal_checkbtn;
    [GtkChild]
    private Gtk.Revealer goal_revealer;
    [GtkChild]
    private Gtk.Entry title_entry;
    [GtkChild]
    private Gtk.SpinButton hours_spnbtn;
    [GtkChild]
    private Gtk.SpinButton minutes_spnbtn;
    [GtkChild]
    private Gtk.Button newtask_btn;

    private MainModel model;

    public Window (Gtk.Application app, MainModel model) {
        this.application = app;
        this.model = model;
        this.resizable = false;

        drawTasks();

        tasks_listbox.row_activated.connect((row) => {
            (row as TaskWidget).toggleControls();
        });

        // Apply styles
        var provider = new Gtk.CssProvider();
        provider.load_from_resource("/com/github/Elnee/Tracky/views/ui/style.css");
        Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(),
            provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        tasks_listbox.get_style_context().add_class("tasks-listbox");
    }

    private void drawTasks() {
        for (int i = 0; i < model.nTasks; ++i) {
            Tracky.Task task = model.getTask(i);
            addTaskToList(task);
        }
    }

    private void addTaskToList(Tracky.Task task) {
        TaskWidget task_widget;

        if (task is Tracky.TaskGoal) {
            task_widget = new TaskGoalWidget(task);
        } else {
            task_widget = new TaskWidget(task);
        }

        tasks_listbox.add(task_widget);
    }

    private void clearNewtaskSection() {
        title_entry.text = "";
        hours_spnbtn.value = 0;
        minutes_spnbtn.value = 0;
        withgoal_checkbtn.active = false;
    }

    //
    //  New task section
    //

    [GtkCallback]
    void on_newtask_btn_clicked() {
        main_stack.visible_child_name = "newtask_page";
        newtask_btn.sensitive = false;
    }

    [GtkCallback]
    void on_withgoal_checkbtn_toggled() {
        if (withgoal_checkbtn.active) {
            goal_revealer.set_reveal_child(true);
        } else {
            goal_revealer.set_reveal_child(false);
        }
    }

    [GtkCallback]
    void on_cancelcreate_btn_clicked() {
        main_stack.visible_child_name = "tasks_page";
        clearNewtaskSection();
        newtask_btn.sensitive = true;
    }

    [GtkCallback]
    void on_createtask_btn_clicked() {
        main_stack.visible_child_name = "tasks_page";
        var goal = Helper.hmToSeconds(hours_spnbtn.get_value_as_int(),
                                   minutes_spnbtn.get_value_as_int());
        var task = model.addNewTask(title_entry.text, goal);
        addTaskToList(task);
        clearNewtaskSection();
        newtask_btn.sensitive = true;
    }
}
