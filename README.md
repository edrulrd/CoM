# CoM
Change of (system) Management - bash utility program to document internal system administration changes on Linux like systems

## Overview

**CoM** is a bash-based command-line (non-graphical) utility program that can be used to manually keep track of changes made to the running system.  It has been found to be useful, for example, when upgrading to a new distro, when you need to recollect the changes that were made to a prior system.  Or, you may remember doing a task previously, and need to modify or repeat what you did, but don't remember the exact steps you took last time.  Or, you rememeberd some off-beat package you installed before but forgot where it was housed.  Or, you discovered that you applied some changes to the wrong part of the system because you recently discovered that a patch update over-wrote your change because you updated the wrong file and you need to re-apply it again to the correct file this time.  Having access to your change logs that you made allows you to quickly redo what you did before.  It can also be used as a means to transfer knowledge to less experienced system administrators.

**CoM** is a simple bash script and should run on any linux or unix variant.  If it turns out that some internal commands do not produce the desired output, even relatively inexperienced system administrators will likely be able to adapt or extend the script to make it work for their particular environment simply by making any minor adjustments.

Note that recording information about the change is completely asynchronous and separate from making the change, and this program only documents the changes being implemented.  It simply creates documentation and thus, with suitable tailoring, could be used to record information about any desired event.  Oftentimes, the typical flow is to have 2 X-windows open; one to make the changes in, and another to manually paste the commands and output generated from the first window into the file opened by CoM.

## Purpose

**CoM** constructs a default form within the program, automatically supplies rudimentary information about the running system (i.e. hostname, issuer, date, type of system and operating system version, kernel information, etc), and then manually collects information provided by the invoker. The program asks the user for a summary describing the change that is being recorded.  Most of the information collected can be through copy and pastes of already executed commands from other terminal windows.  After the user has collected the desired information, when saved, it stores the collected data into a new file in a designated directory.

One nice feature available is to use the CoM Plugin available in the cfg2html program.  It will display the Summary information from the changes that have been recorded on this system.  See https://github.com/cfg2html/cfg2html for details.


## Where to get CoM

CoM works on Linux, HP-UX, SunOS, AIX etc.

The GitHub Source development tree is available at <https://github.com/edrulrd/CoM>.  You can clone it to your curent working directory via:

    git clone https://github.com/edrulrd/CoM
    cd CoM
    
If you want to install and run the program from the system libraries instead of from your own home directory, you can issue
    make help
    make install
This may be useful if several system administrators should be recording changes on the same system.


## Issue Tracker

If you find a problem or bug, want to discuss feature requests, or have some bright new ideas, please create a new issue on our GitHub project page <https://github.com/edrulrd/CoM/issues.>
When using it, please ensure that any criticism you provide is constructive. Please do not use the issue tracker for general help and assistance with using CoM.

Feel free to open a pull request to fix a problem yourself or to contribute a new feature. 

## Contributing on GitHub

To contribute to a project that is hosted on GitHub.com, you first would sign-up for a (free) account. Once signed in, go to the desired project and fork it.  You will then be able to clone your fork locally as indicated below, make any desired changes, then push it back to your GitHub account, and then issue a pull request to request the changes be integrated into the maintainer's source.

Please try to keep pull requests as small as possible - one new feature or fix set per pull request is preferred. This makes it easier to review and discuss your contribution.  To summarize the git command-line flow:

Fork project on github:

    git clone https://github.com/your-github-userid/CoM
    cd CoM
    repeat: (edit), (test) until OK
    git add (modified files)
    git commit -m 'Explanation of what I changed'
    git push origin master

Then sign-in to your github.com account and click the ‘pull request’ button from the https://github.com/edrulrd/CoM repository.

#### Credits

Inspiration for maintaining localized, nitty-gritty change logs of this type came from Philip Smith in the 1990's.
----
> $Id: README.md,v 1.00 2020/11/24 21:30:00 edrulrd Exp $

<!-- Atom:set encoding=utf8 lineEnding=unix grammar=md tabLength=4 useSoftTabs: -->
<!-- vim:set fileencoding=utf8 fileformat=unix filetype=md tabstop=4 expandtab: -->
