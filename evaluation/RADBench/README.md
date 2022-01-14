 "INTEL CONFIDENTIAL
 Copyright (February 2011) Intel Corporation All Rights Reserved.
 
 The source code contained or described herein and all documents
 related to the source code ("Material") are owned by Intel Corporation
 or its suppliers or licensors. Title to the Material remains with
 Intel Corporation or its suppliers and licensors. The Material may
 contain trade secrets and proprietary and confidential information of
 Intel Corporation and its suppliers and licensors, and is protected by
 worldwide copyright and trade secret laws and treaty provisions. No
 part of the Material may be used, copied, reproduced, modified,
 published, uploaded, posted, transmitted, distributed, or disclosed in
 any way without Intel~Rs prior express written permission.  No
 license under any patent, copyright, trade secret or other
 intellectual property right is granted to or conferred upon you by
 disclosure or delivery of the Materials, either expressly, by
 implication, inducement, estoppel or otherwise. Any license under such
 intellectual property rights must be express and approved by Intel in
 writing.
 
 Include any supplier copyright notices as supplier requires Intel to use.
 
 Include supplier trademarks or logos as supplier requires Intel to
 use, preceded by an asterisk. An asterisked footnote can be added as
 follows: *Third Party trademarks are the property of their respective
 owners.
 
 Unless otherwise agreed by Intel in writing, you may not remove or
 alter this notice or any other notice embedded in Materials by Intel
 or Intel~Rs suppliers or licensors in any way."


------------------------------
Concurrency Bug Benchmarks
------------------------------

------------------------------
Description
------------------------------

This is a selection of large, real-world benchmarks with concurrency bugs.
These were collected by Nick Jalbert (jalbert@eecs.berkeley.edu or
nickjalbert@gmail.com) over September and October 2010.  Questions, comments,
and suggestions are welcome!

------------------------------
Bug Descriptions
------------------------------

Note: we classify bugs into three categories 
    
    -NOT A REAL BUG:  bug report existed but upon deeper inspection it does
                      not appear to be a valid concurrency bug.

    -REAL BUG:        bug report found, bug reproduced, appears to be 
                      a concurrency bug.

    -LIKELY BUT UNCONFIRMED BUG:  bug was discovered in my own tests or bug 
                                  was unfixed at the time the benchmark was 
                                  added to the suite, hence more difficult 
                                  to confirm it is a concurrency bug by 
                                  looking at bug report.

Bug 1:
(NOT A REAL BUG)
Mozilla SpiderMonkey Javascript Engine
Bug Report #515403
https://bugzilla.mozilla.org/show_bug.cgi?id=515403 

Note on Bug 1: Turns out to *NOT* be a real bug (as far as I am concerned).
Atomicity violation in the garbage collector results in various GC methods
being called with NULL pointers.  The initial bug report is difficult to
understand exactly what is going wrong, but it sounds like if you remove the
NULL checks (that are already there) you can cause a crash.  Developers still
greatly restructured code, so potentially some other test harness could expose
a real crash.

Bug 2:
(REAL BUG)
Mozilla SpiderMonkey Javascript Engine
Bug Report #476934
https://bugzilla.mozilla.org/show_bug.cgi?id=476934

Bug 3:
(REAL BUG)
Mozilla SpiderMonkey Javascript Engine
Bug Report #478336
https://bugzilla.mozilla.org/show_bug.cgi?id=478336

Bug 4:
(REAL BUG)
Mozilla NSPR Thread Package 
Bug Report #354593
https://bugzilla.mozilla.org/show_bug.cgi?id=354593

Bug 5:
(REAL BUG)
Mozilla NSPR Thread Package 
Bug Report #165586
https://bugzilla.mozilla.org/show_bug.cgi?id=165586

Bug 6:
(REAL BUG)
Mozilla NSPR Thread Package 
Bug Report #526805
https://bugzilla.mozilla.org/show_bug.cgi?id=526805

Bug 7:
(REAL BUG)
Google Chrome Browser
Issue #52394
http://code.google.com/p/chromium/issues/detail?id=52394

Bug 8:
(REAL BUG)
Memcached
Issue #127
http://code.google.com/p/memcached/issues/detail?id=127

Bug 9:
(REAL BUG)
Google Chrome Browser
Issue #49394
http://code.google.com/p/chromium/issues/detail?id=49394

Bug 10:
(REAL BUG)
Apache httpd Server
Bug #44402
https://issues.apache.org/bugzilla/show_bug.cgi?id=44402

Bug 11:
(REAL BUG -- reproduction difficult, might not fully understand it yet)
Apache httpd Server
Bug #45605
https://issues.apache.org/bugzilla/show_bug.cgi?id=45605

Bug 12:
Google Chrome Browser
(LIKELY BUT UNCONFIRMED BUG)
Issue #46197
http://code.google.com/p/chromium/issues/detail?id=46197

Bug 13:
Google Chrome Browser
(LIKELY BUT UNCONFIRMED BUG)
Issue #?????
<no link yet>

Bug 14:
Google Chrome Browser
(LIKELY BUT UNCONFIRMED BUG)
Issue #49721
http://code.google.com/p/chromium/issues/detail?id=49721

Bug 15:
******ALERT***** 
This bug is taken from Shan Lu + Min Xu's BugBench (mysql_1) and all
credit for the hard work on this one goes to them.
******ALERT***** 
(REAL BUG)
Bug #791
http://bugs.mysql.com/bug.php?id=791

------------------------------
Tips and Tricks
------------------------------

Every bug directory should contain a Makefile and a README along with various
sources and scripts.  The README should give you a general idea of what's going
on, how to execute the program, and (potentially) describe the the Makefile
targets.  Otherwise, executing

$ make

should describe the targets. There are often options to insert sleeps into the
code to make the bug more likely.  For the larger programs, you often have to
first

$ make build

and then you can do various things like

$ make sleep

Also, most bugs should have a scripts/runme.sh script.  This script should
automatically run the buggy program with all the right command line actions
(and/or server setup and teardown).  Moreover, these scripts can also take a
commandline argument to modify the execution, e.g.:

$ ./scripts/runme.sh  

runs the program natively.  

$ ./scripts/runme.sh  "/usr/bin/time"

appends the time command to the commandline and runs the program.  Finally

$ ./scripts/runme.sh  "pin --" 

runs the benchmark under pin.

------------------------------
What were these compiled on
------------------------------

All these benchmarks were confirmed to build and exhibit buggy behavior on a
machine with the following specs (~ 9/15/2010):

$ uname -a
Linux najalber-u64 2.6.32-24-generic #42-Ubuntu SMP Fri Aug 20 14:21:58 UTC 2010 x86_64 GNU/Linux

$ cat /etc/*release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=10.04
DISTRIB_CODENAME=lucid
DISTRIB_DESCRIPTION="Ubuntu 10.04.1 LTS"

$ gcc --version
gcc-4.4.real (Ubuntu 4.4.3-4ubuntu5) 4.4.3
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ ld -v
GNU ld (GNU Binutils for Ubuntu) 2.20.1-system.20100303

------------------------------
Ubuntu Pre-Reqs
------------------------------

Pre-reqs that were installed for Mozilla bugs (bug2 - bug6):
$ sudo apt-get build-dep firefox
$ sudo apt-get install mercurial libasound2-dev libcurl4-openssl-dev libnotify-dev libxt-dev libiw-dev mesa-common-dev autoconf2.13 yasm
$ sudo apt-get install libc6-dev-i386

See docs/mozilla-build-prereqs.html for more info.


Pre-reqs that were installed for WebKit bugs():
$ sudo aptitude install bison flex libqt4-dev libqt4-opengl-dev libphonon-dev libicu-dev libsqlite3-dev libxext-dev libxrender-dev gperf libfontconfig1-dev libphonon-dev 

See docs/webkit-build-prereqs.html for more info.

Pre-reqs for Chrome bugs (7,9,12,13,14):

see docs/chrome-build-prereqs.html

------------------------------
Getting the Benchmark
------------------------------

Clone command for bug benchmarks:

git clone [username]@pslstp2:/nfs/sc/home/najalber/bugs.git [local dir name]

or (to get it from my Intel desktop)

git clone [username]@143.183.81.117:/home/najalber/bugs [local dir name]

or (get it from jf svn repo using git-svn):

git svn clone https://subversion.jf.intel.com/ssg/spi/st/mt-testing mt-testing

------------------------------
Tips
------------------------------

To configure/build a chrome tarball from
http://build.chromium.org/buildbot/official/ 

1) Unzip the source, e.g.:

$ tar xjf chromium-6.0.406.0.tar.bz2

2) Rename the source folder to src:

$ mv chromium-6.0.406.0 src

3) run the following (modify as
appropriate depending on your architecture etc):

$ cd src
$ GYP_DEFINES="linux_fpic=1 python_ver=2.6 target_arch=x64" python build/gyp_chromium
$ make -j8 chrome pyautolib
