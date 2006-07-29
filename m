From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 29 Jul 2006 12:00:59 +0000
Subject: [lm-sensors] Problem with W83792d
Message-Id: <20060729140059.4783687c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CB36A9.9040502@hcl.in>
In-Reply-To: <44CB36A9.9040502@hcl.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nithin,

> 	I m working in "ASUS NCL-DE Board " in RHEL 3.0 UP5,with lmsensors-2.10.0 and i2c-2.10.0
> In this board w83792d is the health monitoring chip.
> But i am not able to get any of the values.The chip is not even detecting using sensors-detect.
> I have inserted modules i2c-i801,i2c-proc,i2c-dev,i2c-core,w83792d.But the chip is not showing
> in /proc/sys/dev/sensors/.

Similar issues were reported with various Asus server boards using the
W83792D chip. The problem was that the SMBus is multiplexed on these
boards, and the BIOS didn't leave the multiplexer in the correct
configuration after boot. Each time, Asus did release a BIOS fixing the
issue.

I just asked our Asus contact about your motherboard, I'll let you know
what he thinks. In the meantime, if you are not already using the
latest BIOS available, I would suggest that you upgrade and see if it
helps.

> The reply i got from 'Asus' is, it using the slave addres as 0x5e,smbus base addres 0x400.
> But the driver for w83792d searches in 0x2c to 0x2f (static unsigned short normal_i2c_range[]
> = { 0x2c, 0x2f, SENSORS_I2C_END };)

This is the same. The I2C addresses are 7-bit, but Asus gave you the
value left-padded in a byte. 0x5e >> 1 = 0x2f, so the chip would show
at address 0x2f in Linux. The driver supports that address, so this
isn't the problem.

Please provide the output of "i2cdetect 0". This will scan your SMBus.
If nothing shows at 0x2c-0x2f, then the W83792D chip is not accessible,
and neither the w83792d driver nor user-space code will work, you need
a BIOS update from Asus.

-- 
Jean Delvare

