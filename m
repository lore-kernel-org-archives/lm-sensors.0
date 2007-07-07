From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 19:53:05 +0000
Subject: Re: [lm-sensors] try to run MAKEDEV if i2c-dev device files are
Message-Id: <20070707215305.6211e914@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>       Author: jwrdegoede
>         Date: Fri Jul  6 21:39:39 2007
> New Revision: 4571
>    Changeset: http://lm-sensors.org/changeset/4571
> 
> Modified:
>    lm-sensors/trunk/prog/detect/sensors-detect
> 
> Log:
> try to run MAKEDEV if i2c-dev device files are missing before aborting (adapted fedora patch)

> --- /lm-sensors/trunk/prog/detect/sensors-detect (revision 4568)
> +++ /lm-sensors/trunk/prog/detect/sensors-detect (revision 4571)
> @@ -2175,6 +2175,9 @@
>    }
>  
>    if (!($use_devfs || $use_udev)) {
> +    if (! -c '/dev/i2c-0' && -x '/sbin/MAKEDEV') {
> +      system("/sbin/MAKEDEV i2c");
> +    }
>      if (-c '/dev/i2c-0') {
>        $dev_i2c = '/dev/i2c-';
>      } else { # default

Another good catch, and maybe we can improve it a bit.

First of all, a question: how many i2c device nodes does your MAKEDEV
create? The one I have in Slackware 9.1 only creates i2c-0 and i2c-1.
This might not be sufficient. Not our fault though.

Secondly, MAKEDEV was in /dev on Slackware, so maybe we could test both
locations?

Then, the good news is that we should be able to drop the reference to
prog/mkdev/mkdev.sh, and finally delete it from the lm-sensors package
(in branch 3.0.0). I don't plan to move it to i2c-tools. On new systems
it's not needed. On old systems, MAKEDEV should do the work.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
