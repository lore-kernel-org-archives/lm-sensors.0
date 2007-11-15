From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Thu, 15 Nov 2007 19:41:35 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <4dfa50520711151141v6a8e9ef6rd17b4c8592c75816@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

> > I recall seeing this problem before. The list archives have a similar
> > problem for an MSI 975x board:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019545.html
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019566.html
> >
> > For that board, the solution was that the Intel ICH7 chip controlled
> > the fan using a GPIO pin.
>
> No. This isn't the same problem I have. He uses the 4-pin connector. I
> only use two case fans on normal 3-pin connectors which are controllable
> by Speedfan under Windows.
>
> > But he wasn't getting a "Permission denied"
> > error. Can you please double-check that you have permission to write
> > to the files? I'm not going to quiz you on your setup (SELinux? or a
> > problem in /etc/sudoers?) -- but I'll take your word for it that it's
> > a driver error and not a sysfs permissions error.
>
> Good point. I'm so stupid. I do a sudo echo "0" > pwm1. So echo "0" is
> executed as root but the file writing not. Ok as root it works. I can
> write something into actually pwm4 and the fan stops.
>
> But pwmconfig does not work either. It says:
>
> ------------------------------------------------------------
> Found the following PWM controls:
>    hwmon0/device/pwm1
> hwmon0/device/pwm1_enable stuck to 1
> Failed to set pwmhwmon0/device/pwm1 to full speed
> Something's wrong, check your fans!
> ------------------------------------------------------------
>
> And  if I try a echo "0" > pwm1_enable I get "bash: echo: write error:
> Invalid argument". echo "2" works. So I think this is one for you.
>
>
> Best Regards and thanks for help
> Alex

I understand the problem now. In the w83627ehf driver, there is this code:
static ssize_t
store_pwm_enable(struct device *dev, struct device_attribute *attr,
                        const char *buf, size_t count)

...

        if (!val || (val > 2))  /* only modes 1 and 2 are supported */
                return -EINVAL;

That is the "write error: invalid argument" error. The reason this
code rejects a write of 0 to pwm_enable is because the w83627ehf does
not have a true "disable" mode. Some other chips will set the pwm
output to 100% when they are disabled. The w83627ehf doesn't have a
disable mode. Of course, setting it to manual and storing 255 in the
pwm would do the same thing.

That's what pwmconfig (lm_sensors version 2.10.4) does:
                # Try pwmN_enable=0
                echo 0 > $ENABLE 2> /dev/null
                if [ "`cat $ENABLE`" -eq 0 ]
                then
                        # Success
                        return 0
                fi

                # It didn't work, try pwmN_enable=1 pwmN%5
                echo 1 > $ENABLE 2> /dev/null
                echo $MAX > $1
                if [ "`cat $ENABLE`" -eq 1 -a "`cat $1`" -ge 190 ]
                then
                        # Success
                        return 0
                fi

So I *think* the problem is in pwmconfig. But yes, manually writing 0
to pwm_enable will give you an -EINVAL.

To be completely honest, I haven't run pwmconfig in a while. I know it
generally works, but someone should probably post a patch to get it to
work smoothly with w83627ehf and w83627dhg chips. (I could do that...
given lots of time :-)

Hope that helps,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
