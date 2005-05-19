From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: 2.8.1
Message-Id: <20031026185741.35607757.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I wanted to update kernels and userland for 2.8.1 but the install
> guide contains only i2c-patches for 2.8.0.
> 
> Do the 2.8.0 patched out-of-the-tree kernel modules (ivtv, bttv etc.)
> need any further patching?

2.8.0 and 2.8.1 are the same WRT structure problems, so yes, modules
still require patching, using the same patches.

You'll find a patch for Linux 2.4.22 on my guide page, it was built
using I2C CVS right before the 2.8.1 release, so this is almost a 2.8.1
patch. I'm working on an "official" 2.4.22 patch right now, should be
ready within an hour (just updating the HTML page now, the patch itself
is already ready) and maybe another hour for me to update the two
download sources. I'll let you know as soon as it's ready, since I guess
you'll be wanting to give it a try (and I want testers ;)).

Thanks for your interest in my work and serious in your releases.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
