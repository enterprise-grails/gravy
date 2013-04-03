gravy.bat
=========

_Gravy_ is a simple Grails version manager for Windows OS.

When it comes to managing multiple Grails versions within a host, *nix developers enjoy the benefits of the [GVM](http://gvmtool.net/) tool. Those using Windows OS are however stuck with rather mundane task of tweaking system variables back and forth. It is true that GVM supports [Cygwin](http://cygwin.com/), but Grails shell still has some [rough edges](http://jira.grails.org/browse/GRAILS-8252) in this environment (at least based on my experience, anyway, your millage may vary). In addition, even Cygwin is often not an option for corporate Grails users, who are also those most likely running Windows OS.

Gravy has no intention of competing with GVM and its rich functionality set. Instead, it only addresses the task of switching locally present Grails versions within the active command shell.

Installation
------------

1. Create a common home directory for all Grails versions, e.g. `C:\Grails`. Create a system variable `GRAILS_ROOT` that refers the full path to this directory (without the trailing backslash), e.g. `GRAILS_ROOT=C:\Grails`.

2. Unpack any desired Grails version into a separate sub-directory within the common home. The sub-directory name should correspond to the Grails version within, e.g. `C:\Grails\2.2.0`. Note that you can add or remove a version any time.

3. Optionally, configure one version as default. This is useful when majority of projects are using one Grails version while others are needed for occasional maintenance tasks. Create `GRAILS_HOME` system variable that refers the full path to the specific version sub-directory, e.g. `GRAILS_ROOT=%GRAILS_ROOT%\2.2.0`. Add the path to the executables to the `PATH` system variable. e.g. `PATH=%GRAILS_HOME%\bin;%PATH%`.

4. Download and put `gravy.bat` script somewhere within the system and add the respective directory to the `PATH` system variable, if not already there.

5. Launch a new DOS shell and run `gravy list` command. It should show the list of available Grails versions. 

Usage
-----

* Command `gravy` or `gravy help` shows brief setup and usage instructions.
* Command `gravy list` shows available Grails versions.
* Command `gravy use 2.2.0` enables the specified version (e.g. 2.2.0 in this example) within the current shell.

Internals
---------

When a new DOS shell is started, default configuration always applies. There will be either default Grails version enabled (as per the settings in step 3 above), or no Grails at all. 

Gravy changes (or sets, if does not exist) both `GRAILS_HOME` and Grails `\bin` link in the `PATH` temporarily within the scope of the running shell. If needed, `use` command could be run unlimited number of times (i.e. changing active versions back and forth) as the values are replaced instead of just added. 

**IMPORTANT:** Gravy will not work properly if there is Grails `\bin` path specified directly within `PATH` variable _without_ corresponding `GRAILS_HOME` setting as it has no point of reference for pre-existing setup.
