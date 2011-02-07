From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 18:48:52 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207184852.GB2765@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 07, 2011 at 01:20:22PM -0500, Andrew Lutomirski wrote:
> On Mon, Feb 7, 2011 at 12:58 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > Hi all,
> >
> > I published a new version of the standalone driver for W83667HG-I (NCT6771F, NCT6775F)
> > and NCT6776F at http://roeck-us.net/linux/drivers/w83627ehf/.
> >
> > Key changes are listed in the README file. Most of the reported bugs have been fixed,
> > though I am not sure about PWM configuration on NCT6775F and fan min limits on NCT6776F.
> >
> 
> I don't see a README.  What's w83627ehf.c.18?
> 
Sorry, it is there now. w83627ehf.c.18 is a port of rev1 to 2.6.18.

> > For PWM configuration on NCT6775F, I did not find a problem
> . I can set and read PWM values,
> > but since my board does not connect the chip to actual fans I have no idea if the settings
> > have any effect. So this will need to be re-tested on a board which actually uses the chip
> > for fan control.
> 
> Something's weird.
> 
> # cat pwm2_enable
> 5

5 means it is running in SmartFan IV mode.

> # cat pwm2_mode
> 1
> # echo 1 >pwm2_enable
> # cat pwm2_enable
> 5
> # echo 1 >pwm2_enable
> # cat pwm2_enable
> 5
> # echo 2 >pwm2_enable
> # cat pwm2_enable
> 6
> 
That was a bug. 

> [fiddle with pwm2 here.  values written stick but have no effect.]
> 
> # echo 3 >pwm2_enable
> [root@midnight w83627ehf.656]# cat pwm2_enable
> 8
> [root@midnight w83627ehf.656]# echo 1 >pwm2_enable
> [root@midnight w83627ehf.656]# cat pwm2_enable
> 8
> 
> Note: I won't swear that my motherboard uses this particular chip to
> drive the PWMs, but I assume it does since it can certainly measure
> fan speed w/ this chip and it controls the PWMs somehow.
> 
It uses it per Intel specifications.

Anyway, please try again. I updated the code to fix the pwmX_enable bug.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
