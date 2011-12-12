From: yu8ehurwa2@snkmail.com
Date: Mon, 12 Dec 2011 20:58:32 +0000
Subject: [lm-sensors] unsupported intel smbus controller?
Message-Id: <19012-1323723512-333625@sneakemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Running sensors-detect gives:

 .
 .
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Found unknown SMBus adapter 8086:1c22 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.


from lspci ...
00:1f.3 SMBus: Intel Corporation Cougar Point SMBus Controller (rev 05)

from lspci -n ...
00:1f.3 0c05: 8086:1c22 (rev 05)


I'm running:
lm_sensors-3.1.1-10.el6.i686


How do I set about trying to add support for this controller?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
