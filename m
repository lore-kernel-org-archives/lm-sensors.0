From: thomas536@gmail.com (Thomas Garner)
Date: Wed, 21 Feb 2007 02:55:56 +0000
Subject: [lm-sensors] mcp61 sensors support
Message-Id: <9ef864c50702201855n1b386f8elaf6803cb0aa62797@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
In-Reply-To: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nothing bad seems to have happened.  Here are the results.  Note that
I modified the echo to redirect to
/sys/bus/pci/drivers/nForce2_smbus/new_id, I assume that's what you
meant.

[root at ns ~]# modprobe i2c-nforce2
[root at ns ~]# modprobe i2c-dev
[root at ns ~]# lsmod | grep i2c
i2c_nforce2             5952  0
i2c_dev                 7556  0
i2c_core               21056  2 i2c_nforce2,i2c_dev
[root at ns ~]# echo "10DE 03EB" > /sys/bus/pci/drivers/nForce2_smbus/new_id
[root at ns ~]# dmesg | tail
<snip>
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0xf400
[root at ns ~]# i2cdetect -l
i2c-1   smbus           SMBus nForce2 adapter at f400
Non-I2C SMBus adapter
i2c-0   smbus           SMBus nForce2 adapter at 1c00
Non-I2C SMBus adapter
[root at ns ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
[root at ns ~]# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
[root at ns ~]# ls /dev/i2c-*
/dev/i2c-0  /dev/i2c-1

> Hmmm, OK. If the MCP61 is similar to the previous models, the two SMBus
> controllers correspond to the 2nd and 3rd I/O port ranges. However I am
> surprised because these used to always live back-to-back. In your case
> the two addresses are completely different, which makes me suspect that
> something is different.
>
> Either way, if you want to try, we can instruct the i2c-nforce2 driver
> to handle your chip as a supported one and see what happens. Here's the
> procedure (as root):
>
> modprobe i2c-nforce2
> modprobe i2c-dev
> echo "10DE 03EB" /sys/bus/pci/drivers/nForce2_smbus/new_id
> (check the logs)
> i2cdetect -l
> (you should see the two nVidia SMBus listed)
> i2cdetect 0
> i2cdetect 1
> (assuming the nVidia SMBus are bus numbers 0 and 1)
>
> Please report your results. Beware that bad things might happen if it
> happens that the MCP61 is not actually compatible with the older chips.
> Hopefully nothing a reboot won't fix, though.
>
> --
> Jean Delvare
>

