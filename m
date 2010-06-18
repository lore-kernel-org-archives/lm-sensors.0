From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Jun 2010 16:44:47 +0000
Subject: [lm-sensors] Looking for test coverage: drivers for ltc4261, bmr45X,
Message-Id: <20100618164447.GA28814@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have prototype hardware monitoring drivers for the following devices.

I2C/SMBus:
	LTC4261

PMBus:
	BMR45X (BMR450, BMR451, BMR452, BMR453, BMR454)
	LTC2978
	MAX16064
	MAX8688
	UCD92xx (UCD921x, UCD9220, UCD9240)
	and other PMBus chips with HW monitoring features

Due to lack of HW (still waiting for it), I have not yet been able to test the drivers
with real HW. Drivers were tested by simulating the devices, with a simulation driver
similar to i2c-stub.

If you have access to a board with any of the above chips, and if you have time
to test the drivers, please let me know, and I'll to send you a patch.

Jean - I am not sure if it makes sense to submit the drivers to the list for 
comments/reviews at this time, due to lack of testing with real HW. What do you think ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
