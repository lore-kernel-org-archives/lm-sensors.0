From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040419163354.GB13738@bytesex.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I do know that and keep it in mind. However, I obviously don't know the
> audio and video side of I2C as good as you do. The non-smbus chips I
> thought about are the ones which are part of the lm_sensors project
> (A/D and D/A converters, multiplexers, lcd displays, switches).
> 
> Do you know of any chip on you side using an address in the 0x30-0x3F or
> 0x50-0x5F ranges? If there are, I would need to know what they are and
> how much they like quick writes and byte reads, so that I can refine my
> changes.
> 
> As a side node, I don't expect people to run sensors-detect on
> video-dedicated i2c busses...

That is only one part of the problem.  The sensor modules itself do
probing as well.  So if sensors-detect found a sensor on your smbus
and adds the driver module to the config, that driver module will
look for its sensor on all i2c adapters registered in the system,
i.e. also on TV cards.

Rather than mucking with address lists I'd prefeare to export the .class
field to userspace somehow (ioctl? sysfs?) so sensors-detect can see and
use it as well.  That avoids any address clashes in the first place.

  Gerd

-- 
http://bigendian.bytesex.org
