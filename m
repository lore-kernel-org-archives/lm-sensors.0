From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 30 Jan 2012 19:03:47 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of LM96080
Message-Id: <1327950227.2261.14.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-01-30 at 13:15 -0500, Frans Meulenbroeks wrote:
> 
> 
> 2012/1/30 Guenter Roeck <guenter.roeck@ericsson.com>
>         On Sat, 2012-01-28 at 15:04 -0500, Jean Delvare wrote:
>         > On Sat, 28 Jan 2012 11:23:53 -0800, Guenter Roeck wrote:
>         > > On Sat, Jan 28, 2012 at 01:37:56PM -0500, Jean Delvare
>         wrote:
>         > > > Add detection of the National Semiconductor (now Texas
>         Instruments)
>         > > > LM96080. It is functionally compatible with the LM80 but
>         detection is
>         > > > completely different.
>         > > > ---
>         > > > Frans, if you want to test this, a pre-patched version
>         of
>         > > > sensors-detect is available at:
>         > > > http://khali.linux-fr.org/devel/misc/sensors-detect
>         > >
>         > > Looks good. Should we do the same for
>         drivers/hwmon/lm80.c ?
>         >
>         > I think so, yes. The LM96080 is different enough to have its
>         own chip
>         > name IMHO. The detection in the driver worked for Frans by
>         chance
>         > because the limit registers are all set to 0, but in the
>         general case
>         > it would fail.
>         >
>         
>         You or me or Frans ? Any takers ?
>         
> I can test the sensors-detect (actually remembered it when it was
> about time to go home).
> Wrt the lm80.c changes: not too sure what to do here (and actually I'm
> somewhat time-constrained at the moment)
> 
> Best regards, Frans.
> 
> PS: I probably need a prog to detect a single i2c chip and give a
> return code 1 if the chip is detected and 0 otherwise.
> Afaik something like this does not exist. Right?
> If not the idea is to make a small prog i2ctest bus chip (probably
> inspired by i2cdetect) that does what I need.
> Does this sound like a good plan?

Not that complicated. All we need to do is to add the detection code to
lm80.c, into its _detect function. No problem, I can do that unless Jean
has some spare time. Since Linus did not accept the changes into 3.3,
we'll have some time anyway until the 3.4 commit window opens.

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
