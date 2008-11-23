From: <mattroberds@cox.net>
Date: Sun, 23 Nov 2008 02:28:45 +0000
Subject: Re: [lm-sensors] libsysfs.so.2  problem
Message-Id: <20081122212845.ZJ33C.153809.imail@eastrmwml11>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20081122T093439-684@post.gmane.org>
In-Reply-To: <loom.20081122T093439-684@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

---- skylimit <b.tancic@gmail.com> wrote: 
> i have linux box (slackware, 2.6.18) and lm_sensors already installed.
> when i try to start it, there is an error message :
> 
> ./sensors: error while loading shared libraries: libsysfs.so.2: cannot
> open shared object file: No such file or directory

You might need to install the Slackware package "sysfsutils" to get
libsysfs.so .  See:
http://packages.slackware.it/package.php?q=current/sysfsutils-2.1.0-i486-1

> command sensor-detect on the end says:
> 
> Can't exec "i2cdetect": No such file or directory at ./sensors-detect
> line 5127, <STDIN> line 2.
> Couldn't find i2cdetect program!! at ./sensors-detect line 5127,
> <STDIN> line 2.

i2cdetect should come with the lm-sensors package.  You might be having
a path problem; can you run i2cdetect on its own?  In other words, at a
shell prompt, just type

i2cdetect

and hit enter and see what happens.  If you get a response like "not
found", then probably either the packaged version of lm-sensors that
you have lacks i2cdetect (try reinstalling the package or building from
source), or i2cdetect is installed somewhere that your shell doesn't
know about (try setting $PATH).

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
