From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: ADM1031 / ADM1030 Driver
Message-Id: <20040507221427.4d23d37c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083188185.5337.5.camel@megapc>
In-Reply-To: <1083188185.5337.5.camel@megapc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Again a new version of adm1031 driver attached.
> 
> That version adds:
> 
> 	- add alarms file
> 	- corrected bug on reading fan2 pwm
> 	- setting either fan1_auto_channel or fan2_auto_channel to zero
> 	will disable auto fan control
> 	- disable sampling on update in order to have consistant values
> 	for temp readings and their extended resolution bits.

Your set_fan_div function seems broken to me. Near the end you compute a
value in "reg" but never use it.

You have duplicate defines for configuration register bits. BTW, you seem
to use numerical values instead of these constants in several places.

In update_device, you read configuration register 1 twice.

I don't seem to be able to write non-zero values to fanN_auto_channel.

Fan readings are broken. Fan 1 reads 0, fan 2 reads 1323 and doesn't
change. If I change fan2_div, fan2_input changes. It shouldn't.

Changing PWM values didn't have any effect, even in manual mode.

At some point the driver disabled my chip. I couldn't reproduce it yet.

Long way to go... ;)

-- 
Jean Delvare
http://khali.linux-fr.org/
