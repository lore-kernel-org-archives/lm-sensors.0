From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 05 Feb 2009 10:45:36 +0000
Subject: Re: [lm-sensors] [Patch] libsensors: Ignore directories and
Message-Id: <20090205104536.GB5150@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090205090331.GA5150@ubuntu>
In-Reply-To: <20090205090331.GA5150@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 05, 2009 at 10:53:34AM +0100, Jean Delvare wrote:
> Hi Andre,

Hello Jean,
 
> On Thu, 5 Feb 2009 10:03:31 +0100, Andre Prendel wrote:
> > Sysfs directory of the hwmon devices contains directories and symlinks.
> > 
> > Here is the output on my Thinkpad:
> > 
> >   andre@ubuntu:/sys/class/hwmon/hwmon0/device$ ls -l
> >   insgesamt 0
> >   lrwxrwxrwx 1 root root    0 2009-02-04 19:44 bus -> ../../../bus/platform
> >   lrwxrwxrwx 1 root root    0 2009-02-04 19:42 driver ->
> >   ../../../bus/platform/drivers/thinkpad_hwmon 
> >   -r--r--r-- 1 root root 4096 2009-02-04 19:44 fan1_input
> >   lrwxrwxrwx 1 root root    0 2009-02-04 19:44 hwmon:hwmon0 ->
> >   ../../../class/hwmon/hwmon0 
> >   -r--r--r-- 1 root root 4096 2009-02-04 19:44 modalias
> >   -r--r--r-- 1 root root 4096 2009-02-04 19:44 name
> >   drwxr-xr-x 2 root root    0 2009-02-04 19:44 power
> >   -rw-r--r-- 1 root root 4096 2009-02-04 19:44 pwm1
> >   -rw-r--r-- 1 root root 4096 2009-02-04 19:44 pwm1_enable
> >   lrwxrwxrwx 1 root root    0 2009-02-04 19:42 subsystem ->
> >   ../../../bus/platform 
> >   -r--r--r-- 1 root root 4096 2009-02-04 19:44 temp10_input
> >   -r--r--r-- 1 root root 4096 2009-02-04 19:44 temp11_input
> >   -r--r--r-- 1 root root 4096 2009-02-04 19:44 temp12_input
> >   [...]
> > 
> > IMO we can ignore them looking for subfeatures (in
> > sensors_read_dynamic_chip()), can't we?
> 
> What problem are you trying to solve?

Not a problem. It's just a little improvement.
> 
> > I assume there are no hidden files in the directory, right? That's the
> > reason why I have removed this from condition.
> 
> I've never seen hidden files in sysfs except for sections
> in /sys/module. But the purpose of the original code was merely to skip
> "." and ".." anyway, not hidden files.

At another place (sysfs_foreach_classdev()) there is a comment
explaining the condition.

[...]
      if (ent->d_name[0] = '.')      /* skip hidden entries */
                        continue;
[...]

> > 
> > Any comments or improvements?
> > 
> > ---
> > --- lm-sensors-dev/lib/sysfs.c	2009-01-26 17:43:43.000000000 +0100
> > +++ my-sensors-dev/lib/sysfs.c	2009-02-04 21:59:44.000000000 +0100
> > @@ -360,7 +360,8 @@ static int sensors_read_dynamic_chip(sen
> >  		char *name = ent->d_name;
> >  		int nr;
> >  
> > -		if (ent->d_name[0] = '.')
> > +		/* Skip directories and symlinks.  */
> > +		if (ent->d_type = DT_DIR || ent->d_type = DT_LNK)
> >  			continue;
> >  
> >  		sftype = sensors_subfeature_get_type(name, &nr);
> 
> Links must always be handled with care, sometimes sysfs turns
> directories into links or vice-versa and it has broken user-space code
> in the past. But I guess we can safely assume that device attributes
> will never be links?
> 
> If you really care about performance (and I guess that's the sole
> purpose of your patch) then it's faster to check for ent->d_type !> DT_REG.

Indeed. That's even better.

> You can also move "name = ent->d_name" after this test to make
> the fast path even faster.

This should just avoid needless work and maybe potential errors in
parsing unexpected directory names.

> Out of curiosity, did you actually measure any performance improvement
> with your patch?

I didn't do a measurement. That wasn't the goal.

P.S. To become familiar with the whole code and getting a better
understanding how things work, I walk through the code. And if I found
something that I would do in a different way, I send a patch to you :)

Andre
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
