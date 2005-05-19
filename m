From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040724232202.69523ee0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry for the long delay.
> I was a little busy here.

No problem :)

> I got the package.
> It patched (no *.rej) and compiled fine.
> Attached is a file with some output from my environment.

After both of you reported that fan1 was working OK but fan2 wasn't, I
had to admit that there could be a problem in the driver. It is
theoretically possible that the board maker decides to enable fan1 and
disable fan2 (which is why I didn't react after the first report) but
two reports by two different testers were too much ;)

There was actually a bug in the driver, I wasn't watching the correct
registers when deciding whether to ebable fans or not. Same for PWM
outputs.

This is now fixed in patch tagged beta1:
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-beta1.diff

Please test and confirm that both of you now have fan 1 and 2 working,
and two pwm file sets as well (whether they have an actual effect on fans
is yet another matter).

(You can revert the first patch using "patch -R" before applying this
one, so that you won't waste your time getting a fresh new tree.)

Thanks a lot for testing my code.

Among things that can be done to test the driver more actively:

1* Change fan limits in /etc/sensors.conf, run "sensors -s" and check
that the limits have been set properly. Ditto for divisors.

2* Change the fan limits through sysfs directly. Testing of corner cases
is welcome (large values, negative values, zero). Ditto for divisors.

3* Play with PWM (enable/disable, change speed). Be careful not to stop
your fans completely, systems usually don't like that much.

Thanks again.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
