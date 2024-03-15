# CoM
Change of (system's) Management - bash utility program to document system administration changes on Linux like systems

## Overview

**CoM** is a bash-based, command-line (non-graphical) utility program that can be used to manually keep track of changes made to a running system.  It has been found to be useful later on, for example, when you need to recall the changes that were made on a previous system when you need to install a new distro or migrate to a new variant.  Or, you may remember doing a task previously and need to modify or repeat what you did, but don't remember the exact steps you took last time.  Or, you remembered some off-beat package you installed, but you can't remember what it was called, or forgot where it was housed.  Or, you discovered that you improperly applied some changes to a system-managed file as you henceforth discovered that a patch update over-wrote your change and now you need to re-apply the change again - to the correct, user-managed file this time.  Having access to the change logs that you recorded allows you to hopefully quickly redo what you did before.  Or finally, you find you are having trouble now after having applied some system patches or made some change, and you want to review what updates were applied, and maybe determine what might have led to your new troubles.  It can also be used as a means to transfer knowledge to less experienced system administrators.

**CoM** is a simple bash script and should run on any linux or unix variant.  If it turns out that some internal commands do not produce the desired output, even relatively inexperienced system administrators will likely be able to adapt or extend the script to make it work for their particular environment simply by making any minor adjustments.

Access to the **CoM** command is controlled via group membership.  You do not need to be the superuser to use it.

Note that recording information about the change is completely asynchronous and separate from making the change, and this program's only purpose is just to document the changes being implemented.  It simply adds the documentation that you provde during or after a change and thus, could be used to record information about any desired event.

## Purpose

**CoM** constructs a documentation file using a built-in, pre-defined template within the program that automatically supplies rudimentary information about the running system (i.e. hostname, issuer, date, type of system and operating system version, kernel information, etc), and then manually collects information provided by the invoker. The program asks the user for a summary describing the change that is being recorded.  Then the file is opened for editing to allow the user to modify or add any additional information about the change.  Most of the information collected can be through copy and pastes of already executed commands from other terminal windows.  After the user has collected the desired information, when saved, it stores the collected data into a new file in a designated directory.

## Procedure

The typical flow for creating the documentation is to run the commands to make the changes that you want to record in one X-Window, and run the **CoM** script in another X-Window and then manually copy and paste the commands and their output generated from the first window into the file opened by CoM.  (By the way, it's helpful to have a rather large scroll buffer in the terminal window where the changes are applied so you can be sure to capture the entire change dialog.)  Since recording the change is asynchronous from making the actual change, you need to remember to issue the **CoM** command to manually record the changes, preferably immediately after they are made while the commands and their output remain in the window(s) where the changes were made.  Since all that the **CoM** command does is save information into a text file for later referral, you could include any other information relevant to the change in the file as well.  For example, you could add entries from the kernel or system logs (from /var/log) if your changes were relevant to resolving an issue noticed there.

## Integration with cfg2html

If the cfg2html program is being used to record the current state of your system, one nice feature that can be added to it is to use a CoM Plugin.  You could use it, for example, to  display the summary information of the changes recorded.  This would keep the configuration information along with the changes made to the system in one nice report.  See <https://github.com/cfg2html/cfg2html> for details.

## Other logging program - etckeeper

Obviously, **/etc** is not the only location that system administrators make changes to their managed systems, but a handy program that keeps track of changed files in /etc is **etckeeper**.  It has the advantage of automatically saving any changes made to /etc prior to patch updates.  CoM has the ability to record why a change was made along with the changes made, be them in /etc or elsewhere.  Etckeeper can usually be installed from your distro.

## Where to get CoM

CoM works on Linux, HP-UX, SunOS, AIX etc.

The GitHub Source development tree is available at https://github.com/CoM-Application/CoM.  You can clone it to your current working directory via:

    git clone https://github.com/CoM-Application/CoM
    cd CoM
    
## Installation of CoM


Once downloaded, the configure script should be executed to create a Makefile:

    ./configure

The configure program allows the user to define the location of the directory that will store the change logs, along with where configuration files are to be placed.  Depending on if you are running as the superuser or not, different locations will be recommended.  It is not necessary that the configuration program be run as root if all the files will strictly be under the domain of the executing user (for example if the system it is being set up for is only used by the one user).  On the other hand, if more than one systems administrator could potentially make changes to a system, then CoM should be configured as *root*.  Note that after it is set up, executing CoM as root is not necessary, as write access to the change repository is provided using group access.  The permissions on this folder are defined to cause group ownership to be propagated to each file, thus allowing any member of the group to review and edit files therein.  Given the possible sensitivity of information in these change logs, members in the group should be restricted to persons responsible for making system administration changes to the system.  Oftentimes, using "wheel" or "sudo" (depending on your distro), can be suitable groups to select when installing.


After ./configure is run, a Makefile is created.  If the make command is installed on the system, (installing make is highly recommended), you can issue the 

    make -n install

command to display what the Makefile will do when the command is issued again without the -n option.  As typical for open source software, IT IS YOUR RESPONSIBILITY TO ENSURE THAT NOTHING UNTOWARD OCCURS WHEN THE MAKE COMMAND IS RUN.

After the `make install` command has run, **CoM** is ready to use.

  
## Issue Tracker

If you find a problem or bug, want to discuss feature requests, or have some bright new ideas, please create a new issue on our GitHub project page <https://github.com/CoM-Application/CoM/issues>.
When using it, please ensure that any criticism you provide is constructive. Please do not use the issue tracker for general help and assistance with using CoM.

Feel free to open a pull request to fix a problem yourself or to contribute a new feature. 

## Contributing on GitHub

To contribute to a project hosted on GitHub.com, you first would sign-up for a (free) account. Once signed in, go to the desired project and fork it.  You will then be able to clone your fork locally as indicated below, make any desired changes, then push it back to your GitHub account, and then issue a pull request to request the changes be integrated into the maintainer's source.

Please try to keep pull requests as small as possible - one new feature or fix set per pull request is preferred. This makes it easier to review and discuss your contribution.  To summarize the git command-line flow:

Fork the project on github to your account, then on your test system:

    git clone https://github.com/your-github-userid/CoM
    cd CoM
    repeat: (edit) and (test) until OK
    git add (modified files)
    git commit -m 'Explanation of what was changed'
    git push origin master

Then sign-in to your github.com account and click the ‘pull request’ button from the https://github.com/CoM-Application/CoM repository.

## Credits

Inspiration for maintaining localized, nitty-gritty change logs of this type came from Philip Smith in the 1990's while we were both administering systems at the University of Windsor in Ontario, Canada.

----
> $Id: README.md,v 1.00 2020/11/24 21:30:00 edrulrd_at_hotmail.com Exp $

<!-- Atom:set encoding=utf8 lineEnding=unix grammar=md tabLength=4 useSoftTabs: -->
<!-- vim:set fileencoding=utf8 fileformat=unix filetype=md tabstop=4 expandtab: -->
