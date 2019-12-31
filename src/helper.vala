public class Tracky.Helper : Object {
    public static string secondsToText(int seconds) {
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

    public static int hmToSeconds(int hours, int minutes) {
        return (hours * 60 * 60) + (minutes * 60);
    }
}
