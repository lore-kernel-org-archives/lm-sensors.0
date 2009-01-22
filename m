From: Malcolm Lalkaka <mlalkaka@gmail.com>
Date: Thu, 22 Jan 2009 00:44:30 +0000
Subject: Re: [lm-sensors] Problems with f71882fg and NVIDIA graphics card
Message-Id: <1232585070.6391.104.camel@malcolm>
List-Id: <lm-sensors.vger.kernel.org>
References: <1232481045.6371.77.camel@malcolm>
In-Reply-To: <1232481045.6371.77.camel@malcolm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2009-01-21 at 10:18 +0100, Jean Delvare wrote:
> Hi Malcolm,
> 
> On Wed, 21 Jan 2009 00:40:28 -0800, Malcolm Lalkaka wrote:
> > On Wed, 2009-01-21 at 08:58 +0100, Jean Delvare wrote:
> > > You appear to have a recent nVidia SMBus controller which we do not
> > > support yet (MCP79). If it is compatible with previous nVidia south
> > > bridges then the i2c-nforce2 driver should work. Can you please provide
> > > the output of lspci -d 10de:0aa2 -vxxx?
> > 
> > The output from "sudo lspci -d 10de:0aa2 -vxxx":
> > 00:03.2 SMBus: nVidia Corporation MCP79 SMBus (rev b1)
> > 	Subsystem: eVga.com. Corp. Device 1006
> > 	Flags: 66MHz, fast devsel, IRQ 5
> > 	I/O ports at ff00 [sized]
> > 	I/O ports at 1c00 [sized]
> > 	I/O ports at 1c80 [sized]
> > 	Capabilities: [44] Power Management version 2
> > 00: de 10 a2 0a 01 00 b0 00 b1 00 05 0c 00 00 80 00
> > 10: 01 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 01 1c 00 00 81 1c 00 00 00 00 00 00 42 38 06 10
> > 30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 00 00
> > 40: 42 38 06 10 01 00 02 c0 00 00 00 00 6a 96 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 01 10 00 00 01 14 00 00 01 18 00 00 00 00 00 00
> > 70: 00 00 00 00 00 00 f0 ef 00 00 00 00 01 00 00 00
> > 80: 00 10 fe fe 00 00 00 00 00 00 00 00 00 00 00 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: b1 02 00 00 07 00 00 84 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: d4 30 80 01 01 00 00 00 20 82 00 0a 0d 0d 19 19
> > d0: c0 b0 c0 00 10 00 01 00 05 00 00 00 00 00 00 00
> > e0: 88 10 01 10 60 40 00 4f 80 60 00 00 23 44 44 00
> > f0: 7a ff 3d 67 b7 af 9b f8 90 00 80 80 00 00 00 00
> 
> Looks compatible. You may try loading the i2c-nforce2 driver and then
> run the following command:
> 
> echo "10de 0aa2" > /sys/bus/pci/drivers/nForce2_smbus/new_id
> 
> If thinks go well, you should see the nForce2 SMBus (2 channels) in the
> output of "i2cdetect -l" (after loading kernel module i2c-dev). 

Yes, this command seemed to work.
The output of "i2cdetect -l":
i2c-0	unknown   	NVIDIA i2c adapter              	N/A
i2c-1	unknown   	NVIDIA i2c adapter              	N/A
i2c-2	unknown   	NVIDIA i2c adapter              	N/A
i2c-3	unknown   	SMBus nForce2 adapter at 1c00   	N/A
i2c-4	unknown   	SMBus nForce2 adapter at 1c80   	N/A

> Check
> with "i2cdetect <n>" (where n is the bus number) that they behave OK.

The output of "sudo i2cdetect 3":
-----
        WARNING! This program can confuse your I2C bus, cause data loss and worse!
        I will probe file /dev/i2c-3.
        I will probe address range 0x03-0x77.
        Continue? [Y/n] 
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        70: -- -- -- -- -- -- -- --                         
-----

The output of "sudo i2cdetect 4":
-----
        WARNING! This program can confuse your I2C bus, cause data loss and worse!
        I will probe file /dev/i2c-4.
        I will probe address range 0x03-0x77.
        Continue? [Y/n] 
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        20: -- -- 22 -- -- -- -- -- -- -- -- -- -- -- -- -- 
        30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        40: -- -- -- -- -- -- -- -- 48 49 -- -- -- -- 4e -- 
        50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- -- 
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        70: -- -- -- -- -- -- -- --                         
-----

Does that mean they're working? I don't see any new information when
running "sensors", though.

EVGA replied to my support request about the PnP BIOS bug that you
found. They said that if "there is a specific reason why you suspect a
PnP bug in the bios, please let us know and we can pass that information
to our product management team to look into." How can I describe this
problem to them? Since you've already found the problem, I may as well
get them to fix it.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
