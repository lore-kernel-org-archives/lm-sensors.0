From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073554584.3ffd2498612c6@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i've found the driver for winbond chip w83l785ts.c you have written.
> i own this chip (asus a7n8x), so i want to use it.

Preliminary disclaimer: the driver is still considered beta stuff, and I
expect bus problems on a number of systems.

> but i wasn't able to build the lmsensors-cvs-vsersion because i'm
> using kernel 2.6.0. so i tried to build it as an extra kernel module,
> but i failed cause i didn't know how to do it. (i just tried some
> ways, i thought it could work)

Drivers have to be ported in order to work under Linux 2.6.x. They don't
work out-of-the-box, far from that, so no surprise you did not
succeed.

BTW, if you are interested in sensors, you should consider upgrading to
2.6.1-rc1 or later, since -rc1 contains a huge number of fixes of all
sorts. Also, you will need lm_sensors CVS for w83l785ts support, and
lm_sensors CVS has a change that breaks support of 2.6.0 (long story,
but this is needed).

> so it would be nice, if you would tell me, how i can compile it for
> kernel 2.6.0 as module (if it works with 2.6.0 also)

Two choices:
1* Read Documentation/i2c/porting-clients as found in linux 2.6.1-rc1
and later, and port the driver yourself. That's not very complex if you
can follow a guide, especially since the w83l785ts.c driver is really
simple (and read-only for now). Feedback about the guide is welcome.
Questions are welcome too.
2* Wait for me to have some time to do it. The problem here is that the
waiting time is undetermined. Could be ready tomorrow, or in two weeks,
or never if I forget about it. And I'm busy these days (who isn't?).

Good luck :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
