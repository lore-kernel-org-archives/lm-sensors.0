From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 12:41:54 +0000
Subject: [lm-sensors] lm-sensors 2.10.8 has been released!
Message-Id: <20081216134154.3dfddc68@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have just released lm-sensors 2.10.8. Changes from 2.10.7 include:

* User-space support for the IT8720F chip.
* Clean-ups to the i2c-i801 and i2c-piix4 bus drivers and lm78, lm90
  and max1619 chip drivers, backported from Linux 2.6.
* Support for the Intel PCH "Ibex Peak" SMBus master.
* Fixes to the decode-dimms.pl and pwmconfig scripts, backported from
  the 3.0.x branch and i2c-tools, respectively.
* Fixes to sensord, in particular it will no longer bail out on
  transient errors.
* Fixed it87 temperature sensor types decoding in sensors.
* Many fixes and improvements to the sensors-detect script.

This is the last large update for this branch. From now on I will
refrain from backporting anything else but needed fixes. I suspect (and
hope) that there are fewer and fewer users for this branch over time,
so I don't want to spend too much time maintaining it.

Philip, please sign the source tarball and copy it to your mirror,
thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
