From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40200F48.2080308@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>>Temp1/CPU:      failed
>>>Temp2/MB:       failed
>>>Temp3/AUX:      failed
> 
> There was a wrong magnitude in libsensors (statuses are not real
> temperatures so a magnitude of 3 wasn't a very subtle choice, my bad).
> Fixed in CVS, if you care to try.

Looks better now, but there are still problems with the fans:

video:~ # sensors
fscher-i2c-0-73
Adapter: SMBus I801 adapter at 2000
Temp1/CPU:      +52.00 C
Temp2/MB:       +44.00 C
Temp3/AUX:      +47.00 C
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
+12V:           +11.79 V
+5V:             +5.05 V
Battery:         +3.05 V

BTW: is it intended, that fscher is found at i2c-1-73 after reloading 
i2c_i801, and at i2c-2-73, ... after reloading it again, ...?

BTW2: your latest diff didn't contain FSCHER's DRIVER_ID.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
