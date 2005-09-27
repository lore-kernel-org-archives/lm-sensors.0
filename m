From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 27 Sep 2005 10:33:56 +0000
Subject: [lm-sensors] Query: LM78 i2c vs ISA, driver update
Message-Id: <es0ij19287vd8dagiqv7degh41mjj0sr4o@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, All,

Updating lm78 driver, now that it has sole ownership of its ISA ioports ;)

Busy locking: commentary states it may deadlock?  Is not avoiding 
collisions between ISA and SMBus as per datasheet desirable?

Anything else I should know while updating this old driver?

Plans:	whitespace / cleanup
	convert to dynamic sysfs
	add auto-fan-div ??
	(perhaps a final cleanup)

Thanks,
Grant.

