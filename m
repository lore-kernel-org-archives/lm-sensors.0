From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Mar 2009 15:12:58 +0000
Subject: Re: [lm-sensors] Adding driver for embedded sensors in an FPGA
Message-Id: <20090319161258.042e6495@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090319001714.28D68818054@mail202-wa4.bigfish.com>
In-Reply-To: <20090319001714.28D68818054@mail202-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Mar 2009 00:17:11 +0000, John Mcgrath wrote:
> Hi All,
> 
>  
> 
> I have two very much newbie questions regarding adding support/a driver
> for temperature/voltage sensors in an FPGA.
> 
> The Xilinx Virtex-5 FPGAs support embedded linux, and also have an
> in-built hardware module that can monitor temperature and 2 system
> voltages, so lm_sensors seem like a perfect fit!

True.

> I would be very interested in adding support for these sensors to the
> embedded linux.
> 
>  
> 
> So my two questions are:
> 
> 1)       These sensors are internal to the FPGA, and can be accessed via
> a system bus, which is not I2C or PCI, etc. How should this driver be
> written to fit in with the other drivers that are supported by
> lm_sensors?
> 
> a.       My guess is to 'fake' being a PCI/I2C device, by simply calling
> it PCI, while the actual HW access will not use these interfaces, but
> the driver would take care of talking to the sensors via the system bus.

Don't even think about it. We went the "fake bus type" way 8 years ago
and it took several years to clean up the mess afterwards. Not again,
please. Especially when there is zero need for it. The system bus is
like ISA some times ago or LPC now, it is covered by the "isa" bus type
as far as libsensors is concerned, and implemented as platform drivers
in Linux 2.6. Just use this.

> b.       How would this affect the sensor detection scripts, any
> suggestions for this?

That type of proprietary hardware sensors do not seem to fit in
sensors-detect. Presumably you know when the sensors in question are
present, you will instantiate a platform device for them, and the
corresponding platform driver will be loaded automatically by udev or
similar. So there is no need for external detection.

> 2)       Is there a guide somewhere that shows how to start writing a
> driver? I've briefly looked at a few under the drivers/hwmon location,
> but if there was a template/tutorial on what exactly was required, that
> would be excellent!

No, we do not have anything like this. But starting from an existing
driver using the same bus type should work well enough. For example
drivers/hwmon/f71805f.c (but there are many others.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
