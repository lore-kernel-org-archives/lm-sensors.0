From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 15:14:46 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <20071118161446.61ab72c6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander, David,

On Fri, 16 Nov 2007 00:15:21 +0100, Alexander Kiel wrote:
> Hi David,
> 
> > I understand the problem now. In the w83627ehf driver, there is this code:
> > static ssize_t
> > store_pwm_enable(struct device *dev, struct device_attribute *attr,
> >                         const char *buf, size_t count)
> > 
> > ...
> > 
> >         if (!val || (val > 2))  /* only modes 1 and 2 are supported */
> >                 return -EINVAL;
> > 
> > That is the "write error: invalid argument" error. The reason this
> > code rejects a write of 0 to pwm_enable is because the w83627ehf does
> > not have a true "disable" mode. Some other chips will set the pwm
> > output to 100% when they are disabled. The w83627ehf doesn't have a
> > disable mode. Of course, setting it to manual and storing 255 in the
> > pwm would do the same thing.
> > 
> > That's what pwmconfig (lm_sensors version 2.10.4) does:
> >                 # Try pwmN_enable=0
> >                 echo 0 > $ENABLE 2> /dev/null
> >                 if [ "`cat $ENABLE`" -eq 0 ]
> >                 then
> >                         # Success
> >                         return 0
> >                 fi
> > 
> >                 # It didn't work, try pwmN_enable=1 pwmN%5
> >                 echo 1 > $ENABLE 2> /dev/null
> >                 echo $MAX > $1
> >                 if [ "`cat $ENABLE`" -eq 1 -a "`cat $1`" -ge 190 ]
> >                 then
> >                         # Success
> >                         return 0
> >                 fi

Note that the failure can be triggered by two conditions: pwmN_enable
not set to 1, or pwmN less than 190. In Alexander's case, pwmN_enable
has the expected value:

> hwmon0/device/pwm1_enable stuck to 1

Which means that the problem is that writing 255 to pwm1 did not work.
No idea why... I agree that the error message could be made clearer,
I'll improve it now.

> > 
> > So I *think* the problem is in pwmconfig. But yes, manually writing 0
> > to pwm_enable will give you an -EINVAL.
> > 
> > To be completely honest, I haven't run pwmconfig in a while. I know it
> > generally works, but someone should probably post a patch to get it to
> > work smoothly with w83627ehf and w83627dhg chips. (I could do that...
> > given lots of time :-)

It already works just fine for me. I am unable to reproduce Alexander's
problem.

> 
> Ok the problem with pwmconfig is the following:
> 
> echo 0 > $ENABLE 2> /dev/null outputs actually 0. This is the 0 from the
> echo. echo 3 > $ENABLE 2> /dev/null would output 3. I have no clue why
> this is the case.

How did you try that, on the command line? $ENABLE is a variable in the
pwmconfig script, on the command line it's undefined, so that can't
work. Your original report doesn't show any "0" printed on the screen.

> 
> This 0 causes the line echo $MAX > $1 to set pwm1 to 0 instead of 255.

I very much doubt it. Both statements are separate, I fail to see how
whatever the first one does could have any influence on the second.

> If I add a > /dev/null to the line echo 0 > $ENABLE 2> /dev/null it
> works as it should.
> 
> So the diff is:
> ----------------------------------------------------------------------
> 127c127
> <               echo 0 > $ENABLE > /dev/null 2> /dev/null
> ---
> >               echo 0 > $ENABLE 2> /dev/null
> ----------------------------------------------------------------------
> 
> Can you submit this patch? I don't have a reasonable access to the
> lm-sensors community.

This patch is not correct, it breaks pwmconfig more than it fixes it.

As explained above, the problem you have is not with setting
pwm1_enable to 1 (that works) but presumably with setting pwm1 to 255.
So you're trying to fix the wrong line of the script.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
