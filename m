From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Feb 2007 16:34:03 +0000
Subject: [lm-sensors] THMC50 support in 2.6 kernel
Message-Id: <20070222173403.3f24c825.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45dd4ac33b0da@wp.pl>
In-Reply-To: <45dd4ac33b0da@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Thu, 22 Feb 2007 08:48:19 +0100, Krzysztof Helt wrote:
> I tried to find the driver for old Compaq AP550 workstation
> (board name Compaq SW-400). According to the sensor-detect it was
> ADM1022 handled by the thmc50 driver.
> 
> Unfortunately, there was no thmc50 driver in the 2.6.20 kernel tree.

Correct. I don't remember anyone being interested in porting this
driver to 2.6, or even using it there.

> I started porting the driver to the 2.6.20 kernel. Is it worth my
> time?

Sure, if you need it. This appears to be a very simple device, porting
the driver shouldn't be too hard. That being said, it appears that the
thmc50 driver isn't supported in sensors nor sensord. This suggests
that it wasn't widely used, so the original driver might not be
perfect. The libsensors support might also not be correct, if it was
never tested.

In fact, it might be quicker to start from a similar 2.6 driver (e.g.
adm1021 or lm90) and to just update the names and registers. But it's
up to you.

> Who is a receiver of the 2.6 kernel patches for ported sensors
> (this list or another list)?

This list is right for such patches. Make sure you read
Documentation/i2c/porting-clients and
Documentation/hwmon/sysfs-interface. Oh, and
Documentation/CodingStyle ;)

-- 
Jean Delvare

