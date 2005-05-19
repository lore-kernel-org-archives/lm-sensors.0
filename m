From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <4wUENiOK.1098173768.3254780.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Richard,

>Following a cold reboot with the modules in the right order, the
>situation is the same as before: fan RPM and pwm work as before, and the
>cpu temps are wrong by a significant factor.
>
>Looking closer, sensor{1,2,3} are now set to 2. Setting back to 1 makes
>the cpu temps closer to what they should be but are still wrong by a
>factor of 1.7 for temp2 and 0.45 for temp3 - temp1 might always be
>meaningless as only two temps show in the bios monitor.
>
>Any more advice?

Make sure that you use w83627hf module version 2.8.8 (see kernel logs in
/val/log and/or dmesg).

Try loading the module with init=0. Make sure you cold reboot before,
since I suspect that loading the module is what breaks the temperature
readings.

If it still doesn't work, you may still try to comment out one init step
that isn't disabled by init=0 (I think it should, BTW). Edit
kernel/chips/w83627hf.c, search for function w83627hf_init_client.
Comment out the following block:

w83627hf_write_value(client, W83781D_REG_I2C_SUBADDR, 0x89);
w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);

Again, cold reboot before testing (and still use init=0).

If it still doesn't work, I don't have much more ideas. You could
provide a dump of the chip ("isadump 0xC05 0xC06" *before* loading the
driver) and I'd take a look just in case I see something interesting.

Good luck,
Jean
