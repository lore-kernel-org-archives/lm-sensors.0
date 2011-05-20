From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 May 2011 14:32:15 +0000
Subject: Re: [lm-sensors] SMbus smart battery
Message-Id: <20110520163215.503b4085@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU146-W898929E5BCD0B8FBDF065CF8E0@phx.gbl>
In-Reply-To: <BLU146-W898929E5BCD0B8FBDF065CF8E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 May 2011 13:07:22 +0200, Fernando Lopez wrote:
> I'm trying to attached an smbus external sensor to my laptop battery connector (5 pins), so I can develop an application to communicate with. The problem is that, after having read the lm-sensors info, load drivers and install lm tools, apparently I can send i2c/smbus commands to some "i2c" adapter, but these are not the adapter I need to communicate with my sensor attached to the battery, and I do not have any idea how I can find it, if this is possible
> 
> Could anyone give me any advice?

It would be easier if you would at least show us the output of
"i2cdetect -l" on your laptop, so that we know which I2C buses you're
seeing.

The SMBus channel with the Smart Battery is typically used by ACPI
directly and not exposed to the OS. You'll have to check in the DSDT of
your laptop to see if there is any way to access it. There are two
standard implementations for which drivers exist (SMBUS01/CMI/i2c-scmi)
or could be written (ACPI0001 and ACPI0005 if I remember correctly),
and it is also possible that your BIOS vendor implemented enough ACPI
functions to write a custom driver with limited capabilities.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
