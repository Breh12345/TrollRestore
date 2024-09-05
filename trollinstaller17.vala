using GLib;

public class TrollInstaller17App : Gtk.Application {
    private Gtk.Entry entry;
    private Gtk.Button run_button;

    public TrollInstaller17App() {
        Object(application_id: "com.example.TrollInstaller17App");
    }

    protected override void activate() {
        var window = new Gtk.ApplicationWindow(this);
        window.set_title("TrollInstaller17");
        window.set_default_size(800, 400); // Set the window size to 800x400

        // Set the application to prefer dark theme
        Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;

        var vbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
        vbox.set_margin_top(20);
        vbox.set_margin_bottom(20);
        vbox.set_margin_start(20);
        vbox.set_margin_end(20);
        window.set_child(vbox);

        // Create a headline label with a large font size directly
        var headline_label = new Gtk.Label("TrollInstaller17");
        headline_label.set_markup("<span size='xx-large' weight='bold'>TrollInstaller17</span>"); // Set to 'xx-large'
        headline_label.set_halign(Gtk.Align.CENTER);
        vbox.append(headline_label);

        // Add a spacer with 100 pixels vertical size using a fixed-size box
        var spacer = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        spacer.set_size_request(-1, 100); // Set the size request for height
        vbox.append(spacer);

        entry = new Gtk.Entry();
        entry.set_placeholder_text("Discardable system app eg. Tips");
        vbox.append(entry);

        // Add the button with spacing around it
        run_button = new Gtk.Button.with_label("Install TrollStore");
        run_button.set_margin_top(10);    // Add top margin of 10 pixels
        run_button.set_margin_bottom(10); // Add bottom margin of 10 pixels
        run_button.set_margin_start(20);  // Add start margin of 20 pixels
        run_button.set_margin_end(20);    // Add end margin of 20 pixels
        run_button.clicked.connect(this.on_run_button_clicked);
        vbox.append(run_button);

        window.present();
    }

    private void on_run_button_clicked() {
        string system_app = entry.get_text().strip();
        if (system_app.length > 0) {
            try {
                // Run the trollstore.py script
                string[] argv = {"python3", "trollstore.py"};
                Pid pid;
                Process.spawn_async(null, argv, null, SpawnFlags.SEARCH_PATH, null, out pid);
                print("Running trollstore.py with discardable system app: %s\n", system_app);
            } catch (SpawnError e) {
                stderr.printf("Failed to execute: %s\n", e.message);
            }
        } else {
            print("Please enter a discardable system app.\n");
        }
    }

    public static int main(string[] args) {
        var app = new TrollInstaller17App();
        return app.run(args);
    }
}

