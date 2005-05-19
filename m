From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: ADM1031 / ADM1030 Driver
Message-Id: <20040504214412.4b45b125.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083188185.5337.5.camel@megapc>
In-Reply-To: <1083188185.5337.5.camel@megapc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

> ADM1031 driver with activation of monitoring by default.
> 
> removed tempX_enable files as they are for interrupt, not
> measurements.

I'm testing at the moment.

The fans are now starting as I load the driver (well, a few seconds
after), and temperature monitoring works :)

Bugs found:

1* I cannot set temperature critical limits.

2* Whatever I set the PWM values to, the fans turn, probably to full
speed.

3* Fan speed values don't seem to be correct. They read 1323 (which
seems to be the minimal value with divisor = 2) and 0, respectively, and
never change. Since both fans are running at fast speed, it can't be.

Also, your driver doesn't export alarms?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
