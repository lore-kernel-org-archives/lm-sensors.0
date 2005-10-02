From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Oct 2005 14:25:01 +0000
Subject: [lm-sensors] Proposed PEC support reimplementation
Message-Id: <20051002142457.347cf818.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am done with my software PEC support reimplementation. It was faster
and easier than I first thought. Basically, the idea is to operate on
i2c_msg structures rather than i2c_smbus_data unions. This allows to
handle all transactions on I2C adapters rather than only a few ones.
The code is generic rather than transaction specific, so it is
significantly shorter, and is less likely to have bugs. The only
drawback I can think of is that emulating PEC on non-I2C, non-PEC SMBus
masters is no more possible - but this possibility did not seem to be
used, and it was only partly possible by design anyway.

Patches are available for review:

http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-core-drop-pec-funcs.diff

Discard I2C_FUNC_SMBUS_*_PEC defines.

http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-core-rewrite-swpec.diff

The rewrite itself.

http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-core-drop-swpec-sizes.diff

Post-rewrite cleanups.

http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-lm90-adm1032-pec.diff

Usage demonstration, adding PEC support to the lm90 driver for the
ADM1032 chip.

Comments are of course welcome. Testers are very welcome too, both to
make sure that I did not break any non-PEC transaction in the process
(unlikely) and to test the new PEC implementation. There doesn't seem
to be that many PEC-capable devices out there, unfortunately.

Note that all these patches are part of my own current stack of
patches, so they may or may not apply to a vanilla tree. You can pick
the whole patchset here for easier testing:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.14-rc3-i2c.patch.gz

As the name says, it applies to 2.6.14-rc3. Or for quilt users:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.14-rc3-i2c-broken-out.tar.gz

Thanks,
-- 
Jean Delvare
