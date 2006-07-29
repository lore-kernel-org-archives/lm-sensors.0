From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 29 Jul 2006 12:15:15 +0000
Subject: [lm-sensors] Problem with W83792d
Message-Id: <20060729121515.GH25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CB36A9.9040502@hcl.in>
In-Reply-To: <44CB36A9.9040502@hcl.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nithin:

* Nithin <nithinkj at hcl.in> [2006-07-29 15:51:29 +0530]:
> 	I m working in "ASUS NCL-DE Board " in RHEL 3.0 UP5,with lmsensors-2.10.0 and i2c-2.10.0
> In this board w83792d is the health monitoring chip.
> But i am not able to get any of the values.The chip is not even detecting using sensors-detect.
> I have inserted modules i2c-i801,i2c-proc,i2c-dev,i2c-core,w83792d.But the chip is showing in
> /proc/sys/dev/sensors/.
> The reply i got from 'Asus' is, it using the slave addres as 0x5e,smbus base addres 0x400.
> But the driver for w83792d searches in 0x2c to 0x2f (static unsigned short normal_i2c_range[] = { 0x2c, 0x2f, SENSORS_I2C_END };)

That's probably a small misunderstanding about the I2C address space - it has
7 bits address and the 8th is Read/!Write.  So, many device datasheets will 
say e.g. "read at 0x5f and write at 0x5e".  Linux I2C subsystem considers 
the address to be the 7 bits only, right justified.  So when Asus says 0x5e,
they probably mean what Linux thinks is 0x2f.

I don't think we've ever seen a sensor chip reported in the range of
0x50-0x5f.  That is reserved on PCs for the SPD/EEPROMs on your RAM.

After loading i2c-i801 and i2c-dev, what does 'i2cdetect -y 0' tell you?

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


