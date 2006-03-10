From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Mar 2006 13:46:19 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <20060310144619.24210e5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> > > With loops:
> > > [hans at shalem uguru]$ ls -l abituguru.o abituguru.ko
> > > -rw-rw-r-- 1 hans hans 232871 Mar  8 15:14 abituguru.ko
> > > -rw-rw-r-- 1 hans hans 154472 Mar  8 15:14 abituguru.o
> > >
> > > Without loops:
> > > [hans at shalem uguru]$ ls -l abituguru.o abituguru.ko
> > > -rw-rw-r-- 1 hans hans 231191 Mar  9 21:12 abituguru.ko
> > > -rw-rw-r-- 1 hans hans 152816 Mar  9 21:11 abituguru.o
> > 
> > These numbers are really too high, you must have some debugging option
> > enabled. Please provide the same numbers without debugging so that the
> > comparisons make more sense.
> 
> Erm, how do I do that? Also they might be correct this is x86_64 which 
> comes with almost twice as big code and: "wc -l abituguru.c" gives 1473.

Granted, drivers are a bit larger on x86_64 but not to that extent. I
have w83627hf.o around 35 kB on x86 and 51 kB on x86_64, for example.

Please check in your kernel configuration if you have some kernel-wide
debugging option set. These options are under Kernel hacking > Kernel
debugging (most of them are named CONFIG_DEBUG_*, but not all).

I remember that Jim Cromie reported similarly incredible sizes when he
was working on the pc87360 driver. I don't remember what the cause was
(if I ever knew it).

> Sorry no figures, it just doesn't feel right todo all this opens / close 
> if we can pass it all in one file. Also be aware that each open and each 
> read and each close will cause a userspace <-> kernel space context 
> switch syscalls are expensive. Doing this the lots of files way just 
> doesn't feel right for me (I've learned programming on a 8051, so 9k 
> additional data is _huge_ to me).

Well we're not talking about 8051 here (whatever it is) so we have to
think in terms of hardware which actually runs Linux, and 9 additional
kB really isn't much in that respect (or at least not enough to
invalidate my proposed interface.)

However, your point about context switching is interesting. I have to
admit I did not think about it at all until now. Greg, can you please
comment on this point? Imagine that we have 200 sysfs files total for a
driver, and an application which is polling half of them every two
seconds, this means an average 50 such context switches per second.
Does it sound bad?

(As a side question, I am wondering if inotify could be used instead of
polling here? Does inotify work on sysfs? If so maybe this addresses
Hans' objection altogether.)

Greg, you pointed our that there were large amounts of sysfs files in
other areas of the kernel, however do these other areas repeatedly poll
the values found in these sysfs files, like we do to the hwmon drivers?

Thanks,
-- 
Jean Delvare

