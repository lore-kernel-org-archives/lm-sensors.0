From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Apr 2010 11:21:21 +0000
Subject: Re: [lm-sensors] fancontrol EeePC,
Message-Id: <20100425132121.248464b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
In-Reply-To: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mildred,

On Sun, 25 Apr 2010 09:35:58 +0200, Mildred Ki'Lya wrote:
> Hi,
> 
> I am using fancontrol for my new EeePC, and when fancontrol exit (when I
> reboot for example) the fans are set to manual mode at full speed.
> 
> Aparently, the source code of fancontrol first tries to set the fan to safe
> mode, and if it doesn't work, set it to manual at full speed. Apparently,
> the EeePC safe mode is the same as automatic mode. So when we write "0" to
> pwm1_enable, if we read it again, we'll see "2".

This is a bug in the eeepc driver. If it doesn't support mode 0, it
should return -EINVAL when one tries to set it.

> I could find information about EeePC fan control here:
> https://patchwork.kernel.org/patch/64435/
> 
> To enable automatic mode at exit, I changed fancontrol with the following
> patch:
> 
> 
> --- /tmp/fancontrol    2010-04-25 09:31:58.394184626 +0200
> +++ /usr/sbin/fancontrol    2010-04-25 09:21:24.161183983 +0200
> @@ -318,7 +318,7 @@
> 
>      # Try pwmN_enable=0
>      echo 0 > $ENABLE 2> /dev/null
> -    if [ `cat $ENABLE` -eq 0 ]
> +    if [ `cat $ENABLE` -ne 1 ]
>      then
>          # Success
>          return 0
> 
> 
> Do you think this change is worth including it for the next version of
> lm-sensors ?

No. What needs to be fixed is the eeepc driver. We don't want to add
random quirks to user-space applications to work around kernel driver
bugs.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
