From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: i2c_probe() vs i2c_detect()
Message-Id: <20030403012307.GA6037@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi all,

Can anyone tell me why both i2c_probe() and i2c_detect() are in the
kernel at the same time?  They both almost do the same thing, with the
exception being i2c_detect() can handle i2c devices on the isa bus.

It kind of looks like the older i2c code and drivers used the
i2c_probe() call, while the lm_sensors code used i2c_detect().

If there are no objections, I'll merge the two of them, cutting about 2k
out of the kernel :)

thanks,

greg k-h
