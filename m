From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Nov 2007 22:16:18 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <20071121231618.61a8def2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sun, 18 Nov 2007 23:32:12 -0700, David Hubbard wrote:
> I just thought I'd throw in another test point. I was curious if the
> w83627ehf driver was somehow storing "0\n255" or some similar wrong
> behavior:
> 
> # echo 1 > pwm3_enable
> # echo 175 > pwm3
> # echo "0
> > 175" > pwm3
> # cat pwm3
> 175
> # echo -e "0\n175"
> 0
> 175
> # echo -e "0\n175" > pwm3
> # cat pwm3
> 175
> # dmesg | tail
> [  291.436322] allocating slot 0, addr 2e for device 8860
> [  291.436323] found devid:8860 port:2e users:1
> [  291.436331] w83627ehf: Found W83627EHG chip at 0x290
> [  291.436536] releasing last user of superio-port 2e
> [  301.088199] w83627ehf w83627ehf.656: Increasing fan3 clock divider
> from 2 to 4
> [  301.088233] w83627ehf w83627ehf.656: Increasing fan5 clock divider
> from 1 to 2
> [  302.644499] w83627ehf w83627ehf.656: Increasing fan5 clock divider
> from 2 to 4
> [  304.884458] w83627ehf w83627ehf.656: Increasing fan5 clock divider
> from 4 to 8
> [  309.069573] w83627ehf w83627ehf.656: Increasing fan5 clock divider
> from 8 to 16
> [  313.797610] w83627ehf w83627ehf.656: Increasing fan5 clock divider
> from 16 to 32
> 
> 
> Alex, I wonder if your bash is creating a file with "0\n255" in it?
> Because I would feel fairly confident in saying the driver will not be
> able to store a string for later retrieval in pwm3, or pwm1.

The driver doesn't store the input. It parses it and does something out
of the result, and later it prints a value from a register. So it's
strictly impossible for the driver to return something else than a
single integer value when you read from pwm3.

I've added some debugging to the driver and came to the following
conclusion: sysfs splits multi-line writes, and the driver's callback
is called for each line separately. This matches your experience above:
the value written last is returned on the following read.

This however doesn't completely explain Alexander's experience, as for
him, only the _first_ value (the struck 0) appears to be considered by
the driver. But as it seems to be a bash bug specific to Ubuntu (at
least that's what the currently available evidences suggest), there's
little point in spending more time on this. The bug should be reported
to the maintainer of the Ubuntu bash package.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
