From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jun 2008 07:49:09 +0000
Subject: Re: [lm-sensors] adm1021 in 2.6.9 kernel not calling
Message-Id: <20080616094909.01587ff8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Warrick,

On Wed, 04 Jun 2008 11:33:16 -0400, Warrick Lacey wrote:
> I'm presently struggling to bring up the adm1021 driver under 2.6.9 in a 
> VR7 device.

What is a "VR7 device"?

> I see the i2c-piix4 driver attaching and then when the adm1021 is 
> inserted, its attach function is not called, as if the kernel has no 
> adapters to bind to the adm1021_driver.

You can easily check in /sys/class/i2c-adapter if an i2c bus was
created for the PIIX4. Or even easier, run "modprobe i2c-dev &&
i2cdetect -l" as root and see if the PIIX4 SMBus adapter is listed.

If it's not, then the i2c-piix4 driver failed to create the i2c bus.
Are you certain that this is the i2c bus driver you need for your
hardware? Can we see the output of "lspci"? If it is the right driver,
and the driver still fails to create the bus, then I would expect an
error message in the kernel log as you load the i2c-piix4 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
