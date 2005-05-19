From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors shell and Mandrake
Message-Id: <20030921162319.68c8381c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064150341.8374.5.camel@localhost>
In-Reply-To: <1064150341.8374.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> thanks again for your help and I enjoy lm_sensors. I use GKrellm and
> it updates all the time.  Fun.

You're welcome. Happy users are our greatest reward.

> I noticed one thing however that may be particular to my system.  Even
> though the installation script places an lm_sensors shell script in
> /etc/rc.d/init.d and a lm_sensors file in /etc/sysconfig, it is never
> used.

Just to make it clear, lm_sensors doesn't install these files by
default. You have to run sensors-detect in order to create
/etc/sysconfig/lm_sensors, and you have to copy the
prog/init/lm_sensors.init file to /etc/rc.d/init.d/lm_sensors by
yourself.

If you got lm_sensors as a package for your distribution, this process
may have been half or fully automated though.

> Looking at my dmesg output, the only thing starting is the
> lines from the rc.local file I modified.
> 
> I could install the lm_sensors shell script using the SysV editor, but
> I don't want to mess anything up having the rc.local script running
> fine.

Well, as long as things work the way you want, it's alright.

> As feedback, it seems to me that either the install script show
> recommended lines for an rc.* file OR allow the user to install the
> script as part of the start up sequence.
> 
> Right now, I have the files, but they are never used!

The fact that the files are used or not depend on the system. For
example, I have a Slackware system, and it doesn't care a bit about
/etc/sysconfig/. Copying prog/init/lm_sensors.init wouldn't help by
itself, I still would have to tell the system to run that script at
startup, it won't by default. So I have to say that I do not use this
script at all (same as you, it seems) but wrote my own script as
/etc/rc.d/rc.sensors, which I am calling from /etc/rd.c/rc/local.

> Let me know what you think.

How to install lm_sensors highly depends on the distribution, and we
don't support all of them at the moment, so some work by the user may
still be required. I don't consider this a big problem. Usually,
lm_sensors is packaged for distributions with the specific changes to
fit each distribution, so end users don't notice it. For the rest of
them (the ones that compile from the sources), we consider them aware
enough to read the docs and adapt the installation process to their
system on their own.

For most distributions, the only step required is to add a bunch of
symlinks in /etc/rc.d/rc*.d/, to /etc/rc.d/init.d/lm_sensors. This can
usually be automated using chkconfig (if I'm not mistaking). So it's not
that hard, and we can't really take that last step instead of the user.
We consider it the system owner's responsability to decide at which
runlevels lm_sensors should be started.

If you can think of some improvement we could add to our installation
process, let us know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
