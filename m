From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Apr 2007 09:19:15 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070417111915.7df1d93b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Sun, 15 Apr 2007 07:48:42 +0000 (UTC), jk wrote:
> Jean Delvare <khali <at> linux-fr.org> writes:
> > On 08 Apr 2007 16:17:31 -0400, lmsensors <at> kosowsky.org wrote:
> > > Also, just as a random example, the documentation for sensors.conf
> > > when discussing about the BUS STATEMENT (which I found by your reference
> > > below) only talks about /proc/bus/i2c which is obsolete for 2.6
> > > kernels. Similarly, it references the program
> > > prog/config/grab_busses.sh which only works in 2.4 kernels.
> > > 
> > > So, I guess the better question is whether anybody plans on updating
> > > the documentation and auxiliary programs in the lm_sensors tarball to
> > > reflect 2.6 kernels in general and "later" 2.6 kernels in particular.
> > 
> > What about you? Maybe you could stop complaining and actually help the
> > project?
> 
> I believe I have been "asking questions" rather than "complaining". Usually,
> packages have existing maintainers and it would be a bit presumptuous of me as a
> newbie to lm_sensors to start rewriting base code without making sure first that
> I really understand the issue and the reason for the existing situation (which
> you and others have now just explained to me) and second that no one else is
> currently maintaining the code (which indeed it seems that no one else is doing).
> 
> And in fact, I have now adjusted the code to first check for existence of hwmon
> (and I also wrote another cleaner version that only looks at hwmon but I
> understand why you may not want that so as to preserve backwards compatibility.)

Actually, we've branched SVN development now and we have a branch which
will only support recent 2.6 kernels. So if you send this other patch
to us, we could apply it to that branch. Please check your e-mail client
settings first though, as the patch below was corrupted (tabs replaced
by spaces, trailing space deleted), I had to fix it by hand in order to
apply it.

> Anyway, here is the diff for the version that preserves backwards compatibility. 
> 
> --- sens_update_rrd             2007-04-08 01:18:16.000000000 -0400
> +++ sens_update_rrd.new         2007-04-15 03:42:15.000000000 -0400
> @@ -30,6 +30,7 @@
>  then
>         echo "usage: $0 database.rrd sensor"
>         echo "       sensor example: w83781d-isa-0290 (2.4) or 0-0290 (2.6)"
> +       echo "           or hwmon0 (later 2.6)"
>         exit 1
>  fi
>  #
> @@ -38,19 +39,23 @@
> 
>  SENSDIR=/proc/sys/dev/sensors
>  SDIR=/sys/bus/i2c/devices
> -if [ ! -d $SENSDIR ]
> +HWMONDIR=/sys/class/hwmon
> +SENSDEV=$2
> +if [ -d $HWMONDIR ]
>  then
> -       if [ ! -d $SDIR ]
> +       SYSFS=1
> +       SENSDIR=$HWMONDIR
> +       SENSDEV=$SENSDEV/device
> +elif [ -d $SDIR ]
>         then
> -               echo $0: 'No sensors found! (modprobe sensor modules?)'
> -               exit 1
> -       else
>                 SYSFS=1
>                 SENSDIR=$SDIR
> -       fi
> +elif [ ! -d $SENSDIR]
> +then
> +       echo $0: 'No sensors found! (modprobe sensor modules?)'
> +       exit 1
>  fi
> 
> -SENSDEV=$2
>  SENS=$SENSDIR/$SENSDEV
>  if [ ! -r $SENS ]
>  then

Applied, thanks! I fixed the indentation, and also reworded the first
error message so that it's clearer which kernel needs what syntax
exactly.

> > I don't use sens_update_rrd myself, nor prog/config/grab_busses.sh, nor
> > bus statements. You do. Why would you expect me or anyone else to fix
> > them?
> 
> Did I ever say I expected you to? But it is not an unreasonable expectation for
> there to be a maintainer of code or barring that some indication that the code
> is no longer supported. Also, I would think that even if the rrd stuff is seldom
> used that the documentation for a basic config file like sensors.conf should be
> up to date and should not just reference obsolete kernel 2.4 methods which by
> now are four years out of date.
> 
> In any case, I am happy to help where I can, but I don't appreciate being
> accused of complaining or of having unreasonable expectations that I never
> myself expressed or implied.

Sorry, it seems I've been a bit rude with you while you didn't deserve
it. I must have had a bad day or something. Please accept my apologies.

You mentioned that sensors.conf.5 was out-of-date, can you please send
a patch for it too?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
