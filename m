From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 16:34:01 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <20071118173401.393c00dc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Nov 2007 16:57:22 +0100, Alexander Kiel wrote:
> Hi Jean,
> 
> > > Ok the problem with pwmconfig is the following:
> > > 
> > > echo 0 > $ENABLE 2> /dev/null outputs actually 0. This is the 0 from the
> > > echo. echo 3 > $ENABLE 2> /dev/null would output 3. I have no clue why
> > > this is the case.
> > 
> > How did you try that, on the command line? $ENABLE is a variable in the
> > pwmconfig script, on the command line it's undefined, so that can't
> > work. Your original report doesn't show any "0" printed on the screen.
> 
> Yes I did this on the command line (bash). Of course, I replaced the
> $ENABLE variable through pwm1_enable. Try the following command
> in /sys/class/hwmon/hwmon0/device as root:
> 
> echo 255 > pwm1; echo 0 > pwm1_enable 2>/dev/null; echo 1 > pwm1_enable
> 2>/dev/null; echo 255 > pwm1; cat pwm1
> 
> This gives me a 0 on the stdout. But this:
> 
> echo 255 > pwm1; echo 0 > pwm1_enable >/dev/null 2>/dev/null; echo 1 >
> pwm1_enable 2>/dev/null; echo 255 > pwm1; cat pwm1
> 
> gives me 255 on stdout. 

May I ask what shell (and version) you're using? Both sequences above
return 255 here.

> 
> PWM1 has no fan attached in my configuration. It may be the CPU fan
> controller, but I don't have a CPU fan, I have water cooling. I don't
> know if this makes a difference. Currently I have pwm4 working by BIOS
> (ASUS Q-fan control). 

PWM1 has no fan attached on my system either.

> 
> > > This 0 causes the line echo $MAX > $1 to set pwm1 to 0 instead of 255.
> > 
> > I very much doubt it. Both statements are separate, I fail to see how
> > whatever the first one does could have any influence on the second.
> 
> I don't have much experience in shell programming. But is it possible
> that the 0 at stdout stays there until the next command? And than the
> cat 255 > pwm1 would be a echo 0 255 > pwm1.

It would take a broken shell to do what you describe, if that's
possible at all. The following command should answer your question:

echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1

Here, it prints the expected error message, then 255.

> 
> > > If I add a > /dev/null to the line echo 0 > $ENABLE 2> /dev/null it
> > > works as it should.
> > > 
> > > So the diff is:
> > > ----------------------------------------------------------------------
> > > 127c127
> > > <               echo 0 > $ENABLE > /dev/null 2> /dev/null
> > > ---
> > > >               echo 0 > $ENABLE 2> /dev/null
> > > ----------------------------------------------------------------------
> > > 
> > > Can you submit this patch? I don't have a reasonable access to the
> > > lm-sensors community.
> > 
> > This patch is not correct, it breaks pwmconfig more than it fixes it.
> 
> I have pwmconfig v0.8. Maybe the line numbers are not correct in your
> version. I think you will find the right position per hand. a additional
> > /dev/null should not hurt.

I meant that the patch is functionally incorrect, not that I was not
able to apply it (although it is, indeed, technically incorrect, for
it's reverted and not in unified format.)

An additional > /dev/null can certainly hurt, as it overwrites the
previous > $ENABLE, meaning that you do NOT write the value to the
sysfs file at all. It doesn't make a difference for you because writing
0 to pwm1_enable doesn't actually work with the w83627ehf driver, but
your change breaks drivers for which it works.

> 
> > As explained above, the problem you have is not with setting
> > pwm1_enable to 1 (that works) but presumably with setting pwm1 to 255.
> > So you're trying to fix the wrong line of the script.
> 
> Yes the problem is setting pwm1 to 255. But it is set to 0 by pwmconfig
> v0.8. And after my investigation I find out that the 0 comes from this
> echo 0 statement. I than fixed pwmconfig with this additional
> > /dev/null and it worked for me. It worked completely. It found my fan
> attached to pwm4 and all this stuff.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
