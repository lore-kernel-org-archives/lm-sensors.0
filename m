From: ericb@aspsys.com (Eric J. Bowersox)
Date: Thu, 04 Aug 2005 00:35:59 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, third try [0/2]
Message-Id: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After a go-round on the last one, and a round of testing, herewith is
the LM93 driver patch for 2.6, third try.

This is now actually two separate patches, both against 2.6.13-rc3-mm3. 
The first is i2cblock-2.6.13-rc3-mm3.patch, which reintroduces the
i2c_smbus_read_block_data function into i2c-core, because the lm93
driver needs it.  (The code was lifted from the 2.6.5 version of
drivers/i2c/i2c-core.c.)  The second is
lm93-driver-2.6.13-rc3-mm3.patch, the actual driver, which now depends
on that first patch.

On a system with a Supermicro X6DHP motherboard, running SuSE Linux
Enterprise Server 9, the 2.6.13-rc3-mm3 kernel plus these two patches,
and lm_sensors 2.9.1, the lm93 driver now reports fully valid voltages,
temperatures, and fan speeds, *without* requiring the disable_block=1
parameter.  So it's good now from a functional standpoint, at least as
far as we're concerned.

Patches to follow.

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

