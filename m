From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 17:58:06 +0000
Subject: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207175806.GA2634@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I published a new version of the standalone driver for W83667HG-I (NCT6771F, NCT6775F)
and NCT6776F at http://roeck-us.net/linux/drivers/w83627ehf/.

Key changes are listed in the README file. Most of the reported bugs have been fixed,
though I am not sure about PWM configuration on NCT6775F and fan min limits on NCT6776F.

For PWM configuration on NCT6775F, I did not find a problem. I can set and read PWM values,
but since my board does not connect the chip to actual fans I have no idea if the settings
have any effect. So this will need to be re-tested on a board which actually uses the chip 
for fan control.

For the fan min limits on NCT6776F, the code still uses the set of registers starting at
0x63a. The prototype driver we got from Nuvoton does set those registers, so presumably
it should work unless that driver has a bug. Worth to re-test, especially since
I fixed a problem in the speed setting code. 

Please test the new code and let me know if there are any problems. And thanks a lot 
to all the feedback I got for the first revision of the code.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
