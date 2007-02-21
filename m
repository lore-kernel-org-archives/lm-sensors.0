From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Feb 2007 17:39:30 +0000
Subject: [lm-sensors] mcp61 sensors support
Message-Id: <20070221183930.54700a2e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
In-Reply-To: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Tue, 20 Feb 2007 21:55:56 -0500, Thomas Garner wrote:
> Nothing bad seems to have happened.  Here are the results.  Note that
> I modified the echo to redirect to
> /sys/bus/pci/drivers/nForce2_smbus/new_id, I assume that's what you
> meant.

Oops, yes, of course you're right.

> [root at ns ~]# modprobe i2c-nforce2
> [root at ns ~]# modprobe i2c-dev
> [root at ns ~]# lsmod | grep i2c
> i2c_nforce2             5952  0
> i2c_dev                 7556  0
> i2c_core               21056  2 i2c_nforce2,i2c_dev
> [root at ns ~]# echo "10DE 03EB" > /sys/bus/pci/drivers/nForce2_smbus/new_id
> [root at ns ~]# dmesg | tail
> <snip>
> i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
> i2c_adapter i2c-1: nForce2 SMBus adapter at 0xf400
> [root at ns ~]# i2cdetect -l
> i2c-1   smbus           SMBus nForce2 adapter at f400
> Non-I2C SMBus adapter
> i2c-0   smbus           SMBus nForce2 adapter at 1c00
> Non-I2C SMBus adapter
> [root at ns ~]# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: XX 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
> [root at ns ~]# i2cdetect 1
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
> [root at ns ~]# ls /dev/i2c-*
> /dev/i2c-0  /dev/i2c-1

So it appears to work OK. Thanks for testing and reporting, I'll
prepare and submit a patch adding support permanently for the MCP61 to
the i2c-nforce2 driver. I'll also include the MCP65, as I'd be very
surprised that the MCP61 and MCP65 are different in that respect.

That being said, there are no sensors on the SMBus, only one EEPROM. If
there are sensors on your system, they have to be somewhere else, maybe
in the Super-I/O chip. Did you try running a recent version of
sensors-detect already? What did it find?

-- 
Jean Delvare

