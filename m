From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Jan 2009 07:47:45 +0000
Subject: Re: [lm-sensors] Problems with f71882fg and NVIDIA graphics card
Message-Id: <20090122084745.30f76763@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1232481045.6371.77.camel@malcolm>
In-Reply-To: <1232481045.6371.77.camel@malcolm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Malcolm,

On Wed, 21 Jan 2009 16:44:30 -0800, Malcolm Lalkaka wrote:
> On Wed, 2009-01-21 at 10:18 +0100, Jean Delvare wrote:
> > Looks compatible. You may try loading the i2c-nforce2 driver and then
> > run the following command:
> > 
> > echo "10de 0aa2" > /sys/bus/pci/drivers/nForce2_smbus/new_id
> > 
> > If thinks go well, you should see the nForce2 SMBus (2 channels) in the
> > output of "i2cdetect -l" (after loading kernel module i2c-dev). 
> 
> Yes, this command seemed to work.
> The output of "i2cdetect -l":
> i2c-0	unknown   	NVIDIA i2c adapter              	N/A
> i2c-1	unknown   	NVIDIA i2c adapter              	N/A
> i2c-2	unknown   	NVIDIA i2c adapter              	N/A
> i2c-3	unknown   	SMBus nForce2 adapter at 1c00   	N/A
> i2c-4	unknown   	SMBus nForce2 adapter at 1c80   	N/A
> 
> > Check
> > with "i2cdetect <n>" (where n is the bus number) that they behave OK.
> 
> The output of "sudo i2cdetect 3":
> -----
>         WARNING! This program can confuse your I2C bus, cause data loss and worse!
>         I will probe file /dev/i2c-3.
>         I will probe address range 0x03-0x77.
>         Continue? [Y/n] 
>              0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>         00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
>         10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         70: -- -- -- -- -- -- -- --                         
> -----
> 
> The output of "sudo i2cdetect 4":
> -----
>         WARNING! This program can confuse your I2C bus, cause data loss and worse!
>         I will probe file /dev/i2c-4.
>         I will probe address range 0x03-0x77.
>         Continue? [Y/n] 
>              0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>         00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
>         10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         20: -- -- 22 -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         40: -- -- -- -- -- -- -- -- 48 49 -- -- -- -- 4e -- 
>         50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- -- 
>         60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
>         70: -- -- -- -- -- -- -- --                         
> -----
>
> Does that mean they're working?

This looks alright. I'll prepare a patch adding support for the MCP79
to the i2c-nforce2 driver (really just adding the new PCI ID). You
could try dumping the SPD EEPROM at 3-0x50 to make sure it works as
well:
i2cdump 3 0x50 b
i2cdump 3 0x50 c
i2cdump 3 0x50 W
All 3 commands should work and should return the same data.

> I don't see any new information when running "sensors", though.

Well, if the Super I/O chip (F71882FG) is used for hardware monitoring,
then there is no reason why there would be an additional chip on the
SMBus (even though some vendors do it... but not EVGA in my
experience.) Addresses 0x48, 0x49 and 0x4e are often used for thermal
sensors though.

I am also a little curious about the chips at 0x50-0x57 on the second
SMBus channel. Maybe a custom EEPROM...

> EVGA replied to my support request about the PnP BIOS bug that you
> found. They said that if "there is a specific reason why you suspect a
> PnP bug in the bios, please let us know and we can pass that information
> to our product management team to look into." How can I describe this
> problem to them? Since you've already found the problem, I may as well
> get them to fix it.

Description of the problem:

In the PnP ACPI tables, the hardware monitoring I/O ports of the
F71882FG chips are declared at 0x295-0x314, that is, 32 I/O ports
starting at 0x295, while this device uses only 2 I/O ports, so this
should be 0x295-0x296. This problem prevents the OS from using the
device. The BIOS should be fixed to declare only ports 0x295-0x296 for
the hardware monitoring function. My guess is that it's a simple matter
of changing the resource length from 0x20 to 0x02.

You can quote the part of the system log (output of the dmesg command
after boot) which starts with "pnp: PnP ACPI: found 13 devices". It
should include the faulty I/O port range.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
