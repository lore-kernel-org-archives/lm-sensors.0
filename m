From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Mon, 19 Nov 2007 06:32:12 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <4dfa50520711182232r319e6618j3899a6e45f9d2e73@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex, Jean,

> > > It would take a broken shell to do what you describe, if that's
> > > possible at all. The following command should answer your question:
> > >
> > > echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1
> > >
> > > Here, it prints the expected error message, then 255.
> >
> > --------------------------------------------------------------------------
> > root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo
> > 255 > /tmp/pwm1 ; cat /tmp/pwm1
> > bash: echo: write error: Invalid argument
> > 0
> > 255
> > root@alex:~# cat /tmp/pwm1
> > 0
> > 255
> > --------------------------------------------------------------------------
> >
> > As you can see it prints the error message, the 0 and the 255. And you
> > can see both go into /temp/pwm1.
> >
>
> Bummer. That's your shell keeping the initial output (which it failed
> to write to pwm1_enable) in some internal buffer and writing it to pwm1
> later. I'd say shell bug, and a big one at that. And security-related,
> too. I tested on my openSuse 10.3 laptop which has bash version
> 3.2.25(1) as your system does, and couldn't reproduce the problem
> there. Thus I would suspect a Ubuntu-specific patch.

I just thought I'd throw in another test point. I was curious if the
w83627ehf driver was somehow storing "0\n255" or some similar wrong
behavior:

# echo 1 > pwm3_enable
# echo 175 > pwm3
# echo "0
> 175" > pwm3
# cat pwm3
175
# echo -e "0\n175"
0
175
# echo -e "0\n175" > pwm3
# cat pwm3
175
# dmesg | tail
[  291.436322] allocating slot 0, addr 2e for device 8860
[  291.436323] found devid:8860 port:2e users:1
[  291.436331] w83627ehf: Found W83627EHG chip at 0x290
[  291.436536] releasing last user of superio-port 2e
[  301.088199] w83627ehf w83627ehf.656: Increasing fan3 clock divider
from 2 to 4
[  301.088233] w83627ehf w83627ehf.656: Increasing fan5 clock divider
from 1 to 2
[  302.644499] w83627ehf w83627ehf.656: Increasing fan5 clock divider
from 2 to 4
[  304.884458] w83627ehf w83627ehf.656: Increasing fan5 clock divider
from 4 to 8
[  309.069573] w83627ehf w83627ehf.656: Increasing fan5 clock divider
from 8 to 16
[  313.797610] w83627ehf w83627ehf.656: Increasing fan5 clock divider
from 16 to 32


Alex, I wonder if your bash is creating a file with "0\n255" in it?
Because I would feel fairly confident in saying the driver will not be
able to store a string for later retrieval in pwm3, or pwm1.

Hope that helps,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
