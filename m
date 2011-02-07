From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 07 Feb 2011 18:20:22 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <AANLkTimzesTKSf-RWyukcgxu4su-R8MJR-JcDgeWDGvH@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 7, 2011 at 12:58 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Hi all,
>
> I published a new version of the standalone driver for W83667HG-I (NCT6771F, NCT6775F)
> and NCT6776F at http://roeck-us.net/linux/drivers/w83627ehf/.
>
> Key changes are listed in the README file. Most of the reported bugs have been fixed,
> though I am not sure about PWM configuration on NCT6775F and fan min limits on NCT6776F.
>

I don't see a README.  What's w83627ehf.c.18?

> For PWM configuration on NCT6775F, I did not find a problem
. I can set and read PWM values,
> but since my board does not connect the chip to actual fans I have no idea if the settings
> have any effect. So this will need to be re-tested on a board which actually uses the chip
> for fan control.

Something's weird.

# cat pwm2_enable
5
# cat pwm2_mode
1
# echo 1 >pwm2_enable
# cat pwm2_enable
5
# echo 1 >pwm2_enable
# cat pwm2_enable
5
# echo 2 >pwm2_enable
# cat pwm2_enable
6

[fiddle with pwm2 here.  values written stick but have no effect.]

# echo 3 >pwm2_enable
[root@midnight w83627ehf.656]# cat pwm2_enable
8
[root@midnight w83627ehf.656]# echo 1 >pwm2_enable
[root@midnight w83627ehf.656]# cat pwm2_enable
8

Note: I won't swear that my motherboard uses this particular chip to
drive the PWMs, but I assume it does since it can certainly measure
fan speed w/ this chip and it controls the PWMs somehow.

>
> For the fan min limits on NCT6776F, the code still uses the set of registers starting at
> 0x63a. The prototype driver we got from Nuvoton does set those registers, so presumably
> it should work unless that driver has a bug. Worth to re-test, especially since
> I fixed a problem in the speed setting code.

Alarm code still seems to work.

--Andy

>
> Please test the new code and let me know if there are any problems. And thanks a lot
> to all the feedback I got for the first revision of the code.
>
> Guenter
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
