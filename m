From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: driver for mic184 chip
Message-Id: <20050128231810.4e5bde9c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FAB35E.1050208@aeroflex.com>
In-Reply-To: <41FAB35E.1050208@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

> Please find attached the source file (gzip=4k, native.3k) for a 
> mic184 sensor. We have an older driver for the 2.4.2x kernel but it 
> doesn't completely match what your are asking for. I ported it to
> kernel  2.6.9 using your guides, modified i/o to match what you have
> requested,  and have tested to work on our hardware configuration.
> Please let me  know of any changes that need to be made and when it
> might incorporated  into the standard kernel distribution as we will
> be moving forward.

Never heard of that chip before, but it is so similar to the lm75 that
it doesn't make any sense to me to add a different driver to the kernel
tree to handle it.

The only difference your driver really makes (that I can see) is that it
exposes the configuration register to userspace. I don't see much
interest in doing so, since the value isn't anything standard so it
won't help the regular user. Randomly changing the configuration of the
fly isn't exactly clever either, and I can see that you probably never
did that yourself since this part of your driver is obviously broken.

So I don't see much added value to your driver when compared with the
existing, well tested lm75 driver.

> I am also working on drivers for ad5321, pca9540, adm1030, and x24165 
> (all for kernel 2.6.9). We also use DS18B20 and DS2401 one wire
> devices  that I am trying to get working on a ISA bus (through a
> CPLD). If you  are interested in these let me know and I will forward
> them to you when  they are working.

Please note that we already have a driver for the ADM1030 in the 2.6
kernel tree.

There is a preliminary driver for the PCA9540 chip in lm_sensor (for 2.4
kernels) but such multiplexer chips would need to integrate deeped into
the i2c bus architecture instead of being simple chip drivers like I
did. We have plans to do that, part of which are already implemented in
lm_sensors, but nothing functional yet as some points of implementation
still need to be discussed (wish I had more time...)

For one wire devices, you should take a look at the w1 subsystem which
was recently introduced in the 2.6 kernels by Evgeniy Polyakov.

-- 
Jean Delvare
http://khali.linux-fr.org/
