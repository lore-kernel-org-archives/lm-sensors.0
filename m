From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: KSysGuard and lm_sensors
Message-Id: <20030921164853.48216b22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309211402.58124.ml@secondimpact.de>
In-Reply-To: <200309211402.58124.ml@secondimpact.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> My problem, in short terms:
> I can't get KDE's KSysGuard to use lm_sensors as data source. I
> know(!) that there is this /opt/kde/etc/ksysguarddrc config file,
> which works with every other sensor, but only not with LmSensors.
> 
> System:
> Slackware 9,
> Kernel 2.4.22
> KDE 3.1.3 (I know, there is 3.1.4, but the newest instable devel
> release 3.1.91 (-> 3.2) is not solving this problem!)
> i2c 2.8.0
> lm_sensors 2.8.0
> 
> "# sensors" gives output, yes.
> 
> My question: Is this version of KSysGuard and lm_sensors incompatible
> to each other?

No incompatibility is known there, but I had never heard of ksysguard so
far.

> I couldn't install an older version (2.7.0) because
> the "make" on lm_sensors-2.7.0 refused because of "an to old version
> of i2c (>= 2.7.0) which I have compiled and installed before.

This is a known bug of lm_sensors-2.7.0, detailed on our news page. From
news item "May 31st, 2003":

"The lm_sensors compile sees i2c headers in the kernel include directory
before it sees them in /usr/local/include; try the updated Makefile in
CVS for a fix. The new file etc/config.c is also required."
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/config.c

(Not sure that it still works, since the Makefile has been modified many
times since. You may give it a try though.)

> That's all I've got on my mind, for now, I would be happy about any 
> suggestions, thanks for replies!

How did you install ksysguard? If "sensors" is working OK, this means
that the problems comes from ksysguard itself, and we won't be able to
help you much. I'm not using KDE myself, so I can't test. I think you'll
get much more help from the ksysguard guys than from us. If they isolate
the problem as being ours, let us know all the details and we'll fix
whatever needs to be.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
