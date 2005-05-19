From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: SOLVED: I2C and lm-sensors : gentoo-sources 2.4.25 and your
Message-Id: <1083684529.4097b6b1e8fcf@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405031037.51601.Manfred.Knick@T-Online.de>
In-Reply-To: <200405031037.51601.Manfred.Knick@T-Online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Running
>   # sensors -s
> I get
>   w83781d-i2c-0-2d: Can't access procfs/sysfs file for writing;
>   Run as root?

Just one stupid question: were you root?

> # uname -a
> Linux jumbo 2.4.25-gentoo-r2-sensors #15 SMP ... 

I think this is the problem, see below.

> # ll /proc/sys/fs

ll /proc/sys/dev/sensors/w83781d-i2c-0-2d would be more interesting. But I
guess that the files are there, you can most likely read them and write to
those of them which are intended to be. If I'm right, then the explanation
and solution are right below.

> I checked lm_sensors-2.8.6/doc/lm_sensors-FAQ.html Section 4.20
> regarding Linux 2.4.
> 	
> Looks like 
> 	- for 2.4, lm-sensors-2.8.4 is expected, 
> 	- for 2.6, lm-sensors-2.8.6 is expected   ???

Not at all. 2.8.6 if fine for both Linux 2.4 and 2.6. Does our FAQ really
state the contrary?

So, as mentionned below, I suspect that the Gentoo kernel is the problem. I
think I remember that there are additional patches in them (grsec and acl
among others) which are preventing libsensors from working. We never could
understand why, and since these patches are not into the mainline we are
not particularly motivated on investigating. If someone provides a
solution, we'll gladly consider implementing it however.

So I suggest that you try the same operation with a vanilla kernel instead
of a Gentoo-patched one and see if it helps.

-- 
Jean Delvare
http://khali.linux-fr.org/
