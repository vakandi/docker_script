**setup.sh** : 

-This Bash script performs a series of tasks to configure and set up an Apache2 web server for hosting a web application. The script installs required packages and dependencies such as `vim`, `apache2`, `ssh`, `zsh`, `git`, `wget`, `python`, `mariadb-client`, and `mariadb-server`.

-After installing the packages, the script then updates the `apache2.conf` file, sets a new root password and creates a new user `leetsec`. It adds the user to the sudoers file and gives the user permission to use `vim` and `lnav`.

-The script also blocks root ssh login, sets a new port number, and removes warning messages from the `apache2.conf` file. Additionally, it sets up PHP on Apache2, creates a new database, creates a new user and password, and inserts values into the table.

-Finally, the script downloads and installs `ohmyzsh` and copies personal scripts into the root and leetsec home directories. It also sets up the maximum connection per minute on the Apache2 server.

To run the script, save it as a `bash` file and execute it using the command `bash <filename>.sh`. Before running the script, make sure that you have the necessary privileges to execute it.

Note that this script is provided as-is and should be used with caution. Review the script thoroughly before executing it to avoid unintended consequences.

