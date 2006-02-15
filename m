From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 15 Feb 2006 13:34:58 +0000
Subject: [lm-sensors] sysfs
Message-Id: <8iLXEcbe.1140010498.6305800.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1140009470.4260.18.camel@localhost>
In-Reply-To: <1140009470.4260.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello Dominik,

> Long time ago I adapted a simple Program named varyfan to the use of
> sysfs.
> Since I did it the first time, I had to adapt many things over the time
> again and again, because there were many changes in the i2c part of
> sysfs.

If written in C, this program should rely on libsensors so that you
don't have to care about the interface changes.

What does this program do, BTW? If it controls the speed of the fans, you
might want to try the scripts distributed with lm_sensors under
prog/pwm. They have the benefit of being maintained so they keep working
despite interface changes.

> Now I again installed the current kernel onto my machine and nothing of
> my stuff works any more. There were adaptions made in the kernel code
> again, I think. No Problem, but as I wanted to read the documentation
> in the kernel sources I found some black-holes ;-)
>
> porting-clients says:
>
> Use the file names specified in
>   Documentation/i2c/sysfs-interface
>
> But this file does not exist in the Tree since 2.6.13.

True. The documentation was already fixed (in 2.6.16-rc1) to reflect the
fact that this file was moved from Documentation/i2c to
Documentation/hwmon. Thanks for reporting anyway.

> To which (future) point in time do you see some convergence in the
> interface. Why do you generally ever touch a running system?

For fun. Because then users and developers start screaming all around the
place, and this gives us a warm fuzzy feeling of unlimited power :)

Seriously... The interface has been quite stable for the past year at
least. We do out best to keep it stable but we also try to enforce a
number of naming rules so that it is possible to write user-space tools
which can work with all hardware monitoring drivers in a unified way. So
when we discover names which do not comply with the naming rules, we fix
them as soon as possible. We usually keep the old name around for some
times so that people have the time to update their user-space stuff, but
after some time we have to clean it up and only keep the new (correct)
name.

The only area where things have not completely stabilized yet is the
automatic (hardware-driven) fan speed control. There is a proposed
interface but it doesn't seem to please anyone (not that I didn't try
hard...) and not all drivers follow it. I really don't have the time to
work in this area right now, but when I do, changes might occur again,
sorry.

Thanks,
--
Jean Delvare

