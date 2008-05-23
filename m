From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 23 May 2008 14:08:02 +0000
Subject: Re: [lm-sensors] Platforms supported by lm-sensors?
Message-Id: <20080523160802.07cdced5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <54AF3386-036B-44B5-B4C9-D59B175C1A3C@utk.edu>
In-Reply-To: <54AF3386-036B-44B5-B4C9-D59B175C1A3C@utk.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

On Tue, 20 May 2008 19:38:14 -0400, Daniel Lucio wrote:
> does anybody has a list of the platforms supported by lm-sensors? Or  
> a way to generalize where should I be able to run it?

Lm-sensors works on virtually any platform. Most hardware monitoring
chips use standard interfaces (I2C/SMBus, LPC, PCI...) so they can be
found on a variety of systems. In the case of I2C/SMBus, our hardware
monitoring drivers are platform-neutral and what you need is an
underlying I2C/SMBus host controller driver for your platform. Most of
them are under drivers/i2c/busses in the Linux kernel tree.

We advertise hardware support on a per-chip basis, not per-platform
basis. See:
http://www.lm-sensors.org/wiki/Devices

There is a partial list of I2C/SMBus host controller drivers at the
bottom of this page, but it's PC-centric and thus incomplete and
useless for other platforms.

Libsensors itself is hardware-agnostic. All it does is map the sysfs
interface exposed by hardware monitoring chip to an API which is
convenient for C and C++ applications to use.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
