/**
 * @file CliTodoApp.cpp
 *
 * @brief This is a todo app that creates a todo list and stores it in a file.
 *
 * @author Gonzalo Gorgojo
 * Contact: gongorgojo@gmail.com
 *
 */

#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>

using namespace std;

void add(const string &s) // add
{
    ifstream read("todo.txt");
    vector<string> v;
    string temp;

    while (getline(read, temp))
    {
        v.push_back(temp);
    }
    read.close();

    bool check = false; // task not present

    for (const string &task : v)
    {
        if (s == task)
        {
            check = true; // task is already added earlier, but needed to refresh it.
            break;
        }
    }

    if (!check)
    {
        ofstream write("todo.txt", ios::app);
        write << s << endl;
        cout << "Added todo : \"" << s << "\"" << endl;
    }
    else
    {
        ofstream write("todo.txt");

        for (const string &task : v)
        {
            if (task != s)
            {
                write << task << endl;
            }
        }

        write << s << endl;
        cout << "Added todo : \"" << s << "\"" << endl;
    }
}

void del(int k) // delete
{
    ifstream read("todo.txt");
    vector<string> v;
    string s;

    while (getline(read, s))
    {
        v.push_back(s);
    }
    read.close();

    if (k > v.size() || k < 1)
    {
        // if the task number entered is greater than the number of task, then it cannot be deleted or it does not exist.
        cout << "ERROR...! task #" << k << " does not exist! No task is deleted!" << endl;
    }
    else
    {
        ofstream write("todo.txt");
        for (size_t i = 0; i < v.size(); i++)
        {
            if (i != static_cast<size_t>(k - 1))
                write << v[i] << endl;
        }
        cout << "Deleted todo #" << k << endl;
    }
}

void done(int k) // complete
{
    int year, month, date;
    vector<string> v;
    string s, x;

    time_t ttime = time(0);
    tm *local_time = localtime(&ttime);
    year = local_time->tm_year + 1900;
    month = local_time->tm_mon + 1;
    date = local_time->tm_mday;

    ifstream read("todo.txt");

    while (getline(read, s))
    {
        v.push_back(s);
    }
    read.close();

    if (k > v.size())
    {
        cout << "ERROR...! task #" << k << " doesn't exist!" << endl;
    }
    else
    {
        ofstream write1("todo.txt");
        ofstream write2("done.txt", ios::app);
        for (size_t i = 0; i < v.size(); i++)
        {
            if (i == static_cast<size_t>(k - 1))
            {
                x = v[i];
                cout << "Marked todo #" << k << " as done." << endl;
            }
            else
            {
                write1 << v[i] << endl;
            }
        }
        write1.close();
        write2 << "x " << year << "-" << month << "-" << date << " " << x << endl;
        write2.close();
    }
}

void list() // list
{
    ifstream read("todo.txt");
    vector<string> v;
    string s;

    while (getline(read, s))
    {
        v.push_back(s);
    }
    read.close();

    if (v.empty())
    {
        cout << "There are no pending todos." << endl;
    }
    else
    {
        for (int i = v.size() - 1; i >= 0; i--)
        {
            s = v.back();
            v.pop_back();
            cout << "[" << (i + 1) << "]"
                 << " " << s << endl;
        }
    }
}

void help() // help
{
    cout << "How to use this TODO APP :-" << endl;
    cout << "$ ./todoapp add \"todo item\"        # Add a new todo item" << endl;
    cout << "$ ./todoapp del NUMBER             # Delete a todo item" << endl;
    cout << "$ ./todoapp done NUMBER            # Complete a todo item" << endl;
    cout << "$ ./todoapp ls                     # Show remaining todo items" << endl;
    cout << "$ ./todoapp help                   # Show How to use" << endl;
    cout << "$ ./todoapp report                 # Display Statistics of the app." << endl;
}

void report() // status
{
    int pending = 0, done = 0;
    string s;
    int year, month, date;

    ifstream read("todo.txt"); // todo.txt contains the pending tasks;
    if (read.is_open())
    {
        while (getline(read, s))
        {
            pending++;
        }
    }
    read.close();

    ifstream readDone("done.txt"); // done.txt contains the completed tasks
    if (readDone.is_open())
    {
        while (getline(readDone, s))
        {
            done++;
        }
    }
    readDone.close();

    // We will be displaying this with time.

    time_t ttime = time(0);
    tm *local_time = localtime(&ttime);
    year = local_time->tm_year + 1900;
    month = local_time->tm_mon + 1;
    date = local_time->tm_mday;

    cout << year << "-" << month << "-" << date << " "
         << "Pending Tasks: " << pending << " "
         << "Completed Tasks: " << done << endl;
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        cout << "Usage: " << argv[0] << " <command>" << endl;
        help();
        return 1;
    }

    string command = argv[1];

    if (command == "add")
    {
        if (argc < 3)
        {
            cout << "ERROR...! Missing todo string! Nothing added!" << endl;
        }
        else
        {
            string todo = argv[2];
            add(todo);
        }
    }
    else if (command == "del")
    {
        if (argc < 3)
        {
            cout << "ERROR...! Missing task number! No task is deleted!" << endl;
        }
        else
        {
            int taskNumber = stoi(argv[2]);
            del(taskNumber);
        }
    }
    else if (command == "report")
    {
        report();
    }
    else if (command == "done")
    {
        if (argc < 3)
        {
            cout << "ERROR...! Missing task number! No task is marked completed!" << endl;
        }
        else
        {
            int taskNumber = stoi(argv[2]);
            done(taskNumber);
        }
    }
    else if (command == "ls")
    {
        list();
    }
    else if (command == "help")
    {
        help();
    }
    else
    {
        cout << "Invalid command. Use './todoapp help' for usage instructions." << endl;
    }

    return 0;
}

