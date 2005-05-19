From: R.Gregory@liverpool.ac.uk (Richard Gregory)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <4174DCD7.3090108@liv.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, continuing the thread...

Can confirm this is 2.8.8 for both i2c and lm_sensors. init=0 does not 
help, changes sensors{1,2,3} to 2, which gives even more wrong temps. 
Changed the code (those lines don't appear to be skipped with init=0) 
and that had exactly the same effect. This was cold rebooting every time.

Without driver, from a cold reboot. the output of isadump 0xC05 0xC06 is:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
30: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
40: 01 de 1f ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
50: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
60: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
70: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
b0: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
c0: 01 00 00 ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
d0: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
e0: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
f0: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
and then loading the isa driver the output changes to:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
30: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00
40: 01 de 1f ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
50: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
60: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
70: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
b0: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00
c0: 01 00 00 ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
d0: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
e0: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
f0: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00


Richard

Jean Delvare wrote:
> Hi Richard,
> 
> 
>>Following a cold reboot with the modules in the right order, the
>>situation is the same as before: fan RPM and pwm work as before, and the
>>cpu temps are wrong by a significant factor.
>>
>>Looking closer, sensor{1,2,3} are now set to 2. Setting back to 1 makes
>>the cpu temps closer to what they should be but are still wrong by a
>>factor of 1.7 for temp2 and 0.45 for temp3 - temp1 might always be
>>meaningless as only two temps show in the bios monitor.
>>
>>Any more advice?
> 
> 
> Make sure that you use w83627hf module version 2.8.8 (see kernel logs in
> /val/log and/or dmesg).
> 
> Try loading the module with init=0. Make sure you cold reboot before,
> since I suspect that loading the module is what breaks the temperature
> readings.
> 
> If it still doesn't work, you may still try to comment out one init step
> that isn't disabled by init=0 (I think it should, BTW). Edit
> kernel/chips/w83627hf.c, search for function w83627hf_init_client.
> Comment out the following block:
> 
> w83627hf_write_value(client, W83781D_REG_I2C_SUBADDR, 0x89);
> w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);
> 
> Again, cold reboot before testing (and still use init=0).
> 
> If it still doesn't work, I don't have much more ideas. You could
> provide a dump of the chip ("isadump 0xC05 0xC06" *before* loading the
> driver) and I'd take a look just in case I see something interesting.
> 
> Good luck,
> Jean
> 
