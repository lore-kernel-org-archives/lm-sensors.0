From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: New driver for W83L785TS-S
Message-Id: <20031215220548.5946ff22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Just wanted to let you know that we at last have prelimilary support for
the W83L785TS-S chipset, which is found on the Asus A7N8X motherboards.

Feel free to check it out from our lm_sensors2 CVS repository. Note that
you'll need i2c-id.h from CVS as well:
http://www2.lm-sensors.nu/~lm78/cvs/i2c/kernel/i2c-id.h
(Copy it to /usr/local/include/linux or wherever it needs to be on your
system).

You need at least i2c-2.8.1 (or a kernel patch based on it) for the
driver to work. Alsa, lm_sensors2 CVS is meant for 2.4 kernels, not 2.6
ones. I'll port the driver later.

There is the driver and support in sensors-detect, libsensors and
sensors. Still missing are support in sensors.conf and some
documentation.

Over temperature writing is disabled for now, until I have more
information on that particular point. For now, I'm not even sure which
register it is, nor if it is allowed to write to it. Feedback and
information will be welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
