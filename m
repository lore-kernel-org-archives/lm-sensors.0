From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: nforce2 i2c module compilation
Message-Id: <20030806121813.GA15366@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c35b57$0985ec80$0100a8c0@downstairs>
In-Reply-To: <000f01c35b57$0985ec80$0100a8c0@downstairs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jason Longland <killers_soul@hotmail.com> [2003-08-06 18:50:36 +1000]:
> 
> > 2* Is /lib/modules/2.4.20-19.9/build pointing to a real directory, with
> > sources that match your running kernel? Does this dir have a .config
> > file that also match your current config?
> >
> 
> by default with recent rh kernels it seems /lib/modules/<insert version
> here...>/build is actually a real directory, no symlinks involved,
> containing all the necessary headers and configuration bits and pieces to
> compile the 3rd party modules (or whatever the case may be)

No.  It's a symlink, or it *should* be...

mark@jupiter:9[1]$ cat /etc/issue
Red Hat Linux release 9 (Shrike)
Kernel \r on an \m
 
mark@jupiter:9[2]$ uname -a
Linux jupiter.solarsys.private 2.4.20-19.9 #1 Tue Jul 15 17:18:13 EDT 2003 i686 i686 i386 GNU/Linux
mark@jupiter:9[3]$ cd /lib/modules/2.4.20-19.9
mark@jupiter:9[4]$ ls -lad build
lrwxrwxrwx    1 root     root           34 Aug  3 17:20 build -> ../../../usr/src/linux-2.4.20-19.9
mark@jupiter:9[5]$

> at the moment though my kernel version is 2.4.21-something-or-ther... as i'm
> using severn, or trying to...

Maybe they changed this symlink in severn but I very much doubt it.

The only other thing I notice is that you have gcc 3.3, right?  Did
you build this yourself?  RedHat doesn't provide it yet.

 * * * * * * * * * *

Step by step i2c & lm_sensors 2.8.0 on RH9 (derived from my earlier
message: http://archives.andrew.net.au/lm-sensors/msg02553.html):

1) Install the appropriate kernel-source RPM.  Copy the config file
that matches your kernel into its proper place, something like this:

$ cp /usr/src/linux-2.4.20-9/configs/kernel-2.4.20-i686.config \
     /usr/src/linux-2.4.20-9/.config

2) Do *not* do anything else in that tree.  Don't "make clean", don't
"make dep", nothing.  That screws it all up.  Uninstall & reinstall
the RPM if you must.

NOTE: from here on, I assume you're already running the kernel that
matches the config above.  That does make it easier.

3) There is no step 3 anymore ;)

4) Now build & install I2C.

NOTE: If you're using the same tree which failed to build earlier,
please do a "make clean" first.

5) Now build & install lm_sensors2; same note as above.

6) Run sensors-detect, etc.

That's it!  At i2c/sensors 2.8.0 things got much easier for RH users.
The only difference from plain vanilla is that you have to remember
to put that config file in place if you use RH kernels.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
