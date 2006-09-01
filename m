From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Sep 2006 13:46:35 +0000
Subject: [lm-sensors] vt1211 module parameters
Message-Id: <20060901154635.6be81700.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

I noticed that the vt1211 module parameters are not documented. Usually
have a section for them in the Documentation/hwmon/$driver file. Can
you please provide a documentation update adding it?

The patches I applied for the vt1211 driver and documentation are:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-new-driver.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-documentation.patch

Any change you make from now needs to be an incremental patch against
these.

Thanks,
-- 
Jean Delvare

