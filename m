From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: i2c_force_data
Message-Id: <20041109005252.GA26855@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ick, does anyone still use i2c_force_data?

Does the lm_sensors tools create force data that users use on the
modprobe command line?

I'd really like to get rid of that structure (hint, it's the last thing
standing between the current code probe mess, and automatic chip driver
loading when adapters are loaded, like the pci and usb and ieee1394 and
pnp subsystems...)

thanks,

greg k-h
