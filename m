From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Aug 2006 18:41:24 +0000
Subject: [lm-sensors] [patch 0/3] pc87360 - fix unchecked
Message-Id: <20060821204124.ef1d923d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E72DE7.10907@gmail.com>
In-Reply-To: <44E72DE7.10907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim,

> > More interesting would be a comparison of the
> > contents of /sys/class/hwmon/hwmon0/device before and after the
> > patches. If the contents differ, something's wrong, else everything
> > should be OK - or at least there is no regression.
> 
> Your choice of words leaves me unsure whether this is an observation,
> or a requirement.  In any case, its easy, so here it is, plus some other 
> observations.

What difference does it make? I can't force you to do it, and I can't
verify by myself. I can only hope that you want to provide good patches
to the community, and will test your work as much as possible.

It's really about what you want to give to us, rather than what I
request or suggest.

> By contents, I assume you mean the files within the dir:

Yes.

>  diff sys-files-2.6.1*
> 51a52
>  > subsystem@

No idea where this comes from, but not from your patch, for sure. I
guess it's something new, I have such links on 2.6.18-rc4, but I don't
remember seeing them before.

If that's the only difference it means your patch didn't omit any file,
so it works as designed for your chip. Good.

> The files contents change each sample, usually on VPWR, but others too.
> diffs are always in small fractions of a volt.

I didn't mean to compare the contents of the files, of course I know
they can change, and this is completely unrelated with your patch, or
any other change for that matter. We wouldn't be monitoring if values
weren't to change every now and then ;)

> One other thing / oddity I note (again on old kernel, and new/patched).
> Datestamps on the 'files' is not uniform.
> 
> soekris:/sys/class/hwmon/hwmon0/device# ll -tr
> total 0
> < partly snipped >
> lrwxrwxrwx 1 root root    0 Aug 20 23:39 driver -> 
> ../../../../bus/i2c/drivers/pc87360/
> lrwxrwxrwx 1 root root    0 Aug 20 23:39 bus -> ../../../../bus/i2c/
> -r--r--r-- 1 root root 4096 Aug 20 23:39 name
> -r--r--r-- 1 root root 4096 Aug 20 23:39 alarms_in
> -r--r--r-- 1 root root 4096 Aug 20 23:39 alarms_temp
> -r--r--r-- 1 root root 4096 Aug 20 23:39 in1_input
> -r--r--r-- 1 root root 4096 Aug 20 23:39 in10_input
> -r--r--r-- 1 root root 4096 Aug 20 23:39 temp1_input
> -r--r--r-- 1 root root 4096 Aug 20 23:39 temp6_input
> -rw-r--r-- 1 root root 4096 Aug 20 23:39 vrm
> -r--r--r-- 1 root root 4096 Aug 20 23:39 cpu0_vid
> -r--r--r-- 1 root root 4096 Aug 21 08:04 temp6_status
> -rw-r--r-- 1 root root 4096 Aug 21 08:04 temp6_min
> -rw-r--r-- 1 root root 4096 Aug 21 08:04 temp5_min
> -r--r--r-- 1 root root 4096 Aug 21 08:04 temp4_status
> 
> IOW, there are 2 datestamps : Aug 20 23:39  and Aug 21 08:04
> 
> After a reboot (to 2.6.17) shows the same 2 sets of files, this time 
> with closer stamps.
> -r--r--r-- 1 root root 4096 Aug 21 08:42 temp6_input
> -r--r--r-- 1 root root 4096 Aug 21 08:42 cpu0_vid
> -rw-r--r-- 1 root root 4096 Aug 21 08:42 vrm
> -r--r--r-- 1 root root 4096 Aug 21 08:46 temp6_status
> -rw-r--r-- 1 root root 4096 Aug 21 08:46 temp6_max

Yeah, I see similar patterns here. Looks like the files start with
their creation time, then the timestamp gets updated when you write
to (always) or read from them (first time only?)

I can't explain it all, but it makes some sense, and I don't see any
serious problem here anyway. Again, your patch can't have anything to
do with this.

> Also, 8:42 is near the bootup time, but not exactly the same.
> # uptime
>  08:50:13 up 10 min,  1 user,  load average: 3.00, 2.72, 1.54

Most probably the time difference is the time it takes before you reach
the init script which loads the pc87360 driver and/or runs sensors -s.

> rmmod & modprobing recreates the files with current & uniform timestamps.

Until you run "sensors -s" and/or "sensors" (and the read value
changes?), I guess.

-- 
Jean Delvare

