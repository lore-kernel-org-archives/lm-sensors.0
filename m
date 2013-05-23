From: Marc Ferland <ferlandm@sonatest.com>
Date: Thu, 23 May 2013 13:42:02 +0000
Subject: Re: [lm-sensors] [PATCH] fancontrol: Fix handling of absolute paths in config
Message-Id: <87a9nlzuc5.fsf@sonatest.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87obebb9wd.fsf@sonatest.com>
In-Reply-To: <87obebb9wd.fsf@sonatest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> Hi Marc,
>
> On Fri, 22 Mar 2013 13:51:30 -0400, Marc Ferland wrote:
>> The following patch fixes the fancontrol script so it can handle
>> absolute filenames again.
>
> Thanks for the report and the patch, and sorry for the long delay.
>
> You are right that DEVPATH and DEVNAME shouldn't be mandatory when
> using absolute paths in the fancontrol configuration file. DEVPATH
> doesn't even make sense in that case.
>
> However DEVNAME does still make sense. Using absolute paths doesn't
> guarantee that the device you point to after reboot is the same as the
> one you configured originally, unfortunately. Specifically, i2c bus
> numbers aren't guaranteed to be persistent over reboot. So your patch
> is good to get things working again but it prevents the user from
> asking fancontrol to check the device name when using absolute paths.
>
> Thus I would prefer the more flexible change below:
> ---
>  prog/pwm/fancontrol |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> --- lm-sensors.orig/prog/pwm/fancontrol	2013-05-07 08:01:08.589879860 +0200
> +++ lm-sensors/prog/pwm/fancontrol	2013-05-21 10:21:57.223242288 +0200
> @@ -291,11 +291,16 @@ fi
>  cd $DIR
>  
>  # Check for configuration change
> -if [ -z "$DEVPATH" -o -z "$DEVNAME" ]
> +if [ "$DIR" != "/" ] && [ -z "$DEVPATH" -o -z "$DEVNAME" ]
>  then
>  	echo "Configuration is too old, please run pwmconfig again" >&2
>  	exit 1
>  fi
> +if [ "$DIR" = "/" -a -n "$DEVPATH" ]
> +then
> +	echo "Unneeded DEVPATH with absolute device paths" >&2
> +	exit 1
> +fi
>  if ! ValidateDevices "$DEVPATH" "$DEVNAME"
>  then
>  	echo "Configuration appears to be outdated, please run pwmconfig again" >&2
>
> This simply makes DEVPATH and DEVNAME mandatory when using relative
> paths and DEVNAME optional when using absolute paths. Does it work for
> you?

Yes. Just tested on my system and everything seems to run smoothly.

Thank you,

Marc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
