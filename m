From: marekm@amelek.gda.pl (Marek Michalkiewicz)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Matrox G400DH + lm_sensors problem
Message-Id: <20030620001151.GA5184@alf.amelek.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

there is some kind of bad interaction between i2c-matroxfb in
the kernel (2.4.21) patched with lm_sensors 2.6.5.  I have
everything compiled into the kernel (no modules), and when the
Matrox I2C devices are registered at boot time, the machine
hangs for over 3 minutes.  Also, scanning the Matrox I2C buses
(not the motherboard SMBus) with i2cdetect is very slow too.

There is no such hang on boot in the vanilla 2.4.21 kernel
(with no lm_sensors patch applied).  In both cases, the kernel
I2C code is used, and Matrox devices are detected correctly,
it's just that it is sooo much faster without the lm_sensors
drivers compiled into the kernel.

Hardware: Biostar M6TBA motherboard (W83781D sensor chip),
Matrox G400DH 32MB graphics card.  (BTW, the supplied TV-out
cable has the DDC pins SDA and SCL shorted.  Does the kernel
I2C code deal correctly such unusable I2C buses?)

Is this a known problem?  If there is anything I should check
(I'm not brave enough to try the 2.5.x kernels with the latest
lm_sensors just yet...), please tell me.  Thanks!

Marek
