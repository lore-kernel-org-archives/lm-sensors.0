From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Aug 2008 06:54:59 +0000
Subject: Re: [lm-sensors] Why would lm_sensors destroy my KDE environment?
Message-Id: <20080828085459.1cd3cd6c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48B60A6D.3010503@attitia.com>
In-Reply-To: <48B60A6D.3010503@attitia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kyle,

On Thu, 28 Aug 2008 12:16:13 +1000, Kyle wrote:
> Hello again,
> 
> after some assistance from Jean on this list, I determined I apparently 
> don't need lm_sensors. So I decided to remove it from the system. Using 
> the Package Manager, I uninstalled lm_sensors; but it also apparently 
> removed half of my KDE environment (yum confirms the same from the CLI) 
> removing things like 'kdeaddons' and 'kdeartwork' amongst others.
> 
> I don't know what its dependancy is exactly, but it appears to have some 
> hook somewhere into KDE. And that dependancy then removes the rest of 
> the KDE "stuff" (Tech. Term)

If you don't know what its dependency is, how are we supposed to guess?
That's really a distribution issue and there's nothing we can do for
you.

> Consequently, I've lost half a day trying to figure out why I could no 
> longer 'startx' successfully. This is confirmed by now groupinstall -ing 
> KDE  and lm_sensors comes along with it.
> 
> WHY would a program designed to monitor low level MB, CPU and fan 
> sensors have any dependency on a graphical desktop environment?

This is more likely the other way around: some parts of KDE (such as
ksysguard) depend on lm_sensors (or more exactly libsensors, which may
be part of package lm_sensors on your distribution.) Maybe you insisted
too much on removing lm-sensors while you still had packages depending
on it and your package manager had to remove more packages to prevent
broken dependencies.

That's just a guess though... You didn't tell us what you did exactly,
nor which dependencies exist between what packages on your
distribution. But either way this is a distribution issue, nothing the
lm-sensors developers can help with.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
