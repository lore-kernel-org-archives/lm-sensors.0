From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Expose switches in w83781d
Message-Id: <3E2C9F92.7040302@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <15915.5243.486340.725978@hertz.ikp.physik.tu-darmstadt.de>
In-Reply-To: <15915.5243.486340.725978@hertz.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the patch.

I enhanced PWM support to the w83781d driver in late December, it is in CVS.
I also attempted to standardize PWM support across all drivers.
I also put in a userspace tool 'pwmtest', it is in prog/pwm.

If you would give it a try I would appreciate it.

Unfortunately CVS sensors requires CVS i2c and things are difficult
to compile right now, we are making several changes.
You may wish to wait a week or so.

mds


Uwe Bonnes wrote:
> Hallo,
> 
> appended patch exposes the switches in the W83781d. In my Gigabyte BXD6 I
> can switch on and off the fans of the CPU by switching bit 3 off the
> switch. I have a small user space control program that reads out
> /proc/uptime, does some filtering and controls the fan. I would appreciate
> that something like this could goto into the standard lmsensors
> distribution.
> 
> Bye
