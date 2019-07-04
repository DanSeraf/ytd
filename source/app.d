// TODO
// urls extractor
// title, time extractor
// argument parser, for option and configuration

import std.net.curl, std.regex, std.stdio, std.algorithm, std.conv, std.container, std.string, std.process, std.array;

struct Song {
    this(string title, double time, long views) {
        this.title = title;
        this.time = time;
        this.views = views;
    }
}

string search_query = "http://www.youtube.com/results?search_query=";
string watch_query = "http://www.youtube.com/watch?v=";

void main(string[] argv)
{
    string query = argv[1];
    auto content_raw = get(search_query ~ query);
    string content = to!string(content_raw);
    string[] songs = parseContent(content);
    Play(songs);
}

string[] parseContent(string content)
{
    string[] removeClones(string[] arr) {
        string[] toReturn;
        foreach (e; arr) {
            if (!canFind(toReturn, e)) toReturn.insertInPlace(toReturn.length, e);
        }

        return new_arr;
    }

    Song parseContentChunk(string chunk) {
        if (countUntil(chunk, "data-video-ids") != -1)
            {
                long raw_uid_pos = countUntil(chunk, "data-video-ids");
                string uid_raw = chunk[raw_uid_pos+13 .. raw_uid_pos+30];
                long uid_pos = indexOf(uid_raw, "=");
                string uid = uid_raw[uid_pos+2 .. uid_pos+13];

                if (indexOf(uid, "VIDEO") == -1) {
                    ids.insertInPlace(ids.length, uid);
                }
            }
    }

    void getUrlInfo(string chunk) {
        auto content_chunks = ("<h3>");
    }

    auto content_chunks = content.split("</li>");
    string[] ids;
    foreach (cont; content_chunks) {
    }

    return removeClones(ids);
}


void Play(string[] arr)
{
    foreach (uid; arr) {
        string uid_url = watch_query ~ uid;
        auto pid = spawnProcess(["mpv", "--no-video", uid_url]);
        scope(exit) wait(pid);
    }
}
