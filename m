From: Mark Nienberg <gmane@tippingmar.com>
Date: Tue, 27 Jan 2009 18:02:28 +0000
Subject: [lm-sensors] fan control questions
Message-Id: <glni7k$fut$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was hoping to use the fan control program on a server with an ASUS KFN4-DRE 
motherboard.  The BIOS has three settings for control of fans (disabled, smart fan, 
smart fan II). The two smart fan options work very poorly, cycling through full speed 
and low speed on about a 24 hour cycle with no apparent regard to temps.  That is why 
I would like to take control and force something more rational.

I assumed that if I am controlling fans from the OS then I don't want the BIOS to 
also try to control fans, so I set it to "disabled" and then ran the pwmconfig 
program. The program found three pwm devices and tried each one in turn, but there 
was no effect on the two fans connected to the motherboard.  There are a total of 10 
fan connectors on this board, six of which show up in lm_sensors.  The manual says 
that the "smart fan" setting applies to all fan connectors.

Should I have tested with the BIOS settings other than "disabled"?

Should I test the other 4 fan connectors that lm_sensors recognizes?

Or is this just one of the boards that fan control won't be able to handle?  I'm 
using 2.10.6.

Thanks,

Mark Nienberg


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
