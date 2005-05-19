From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: I2C Drivers for Motorola MCF5282
Message-Id: <40BAB45B.8070407@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we have lots of information on our Documentation page that will help you.
Check the sensors project, the i2c project and maybe PPC kernel trees
for the i2c driver that most closely matches the Coldfire, and start from that.
Not familiar w/ Coldfire so can't give you specific guidance.
On adapter/algorithms, generally you should write a 'combined' driver.
Exception is if it is a bit-banger rather than a real i2c subsystem,
if so you only need to write a simple adapter driver and use i2c-algo-bit as the algorithm.
Do you plan to submit your drivers back to us? If so we'll add your
name to our new drivers page.
If you have more questions let us know, we're here to help.
mds


Bill Hull wrote:
> Hi Mark,
> 
> I am currently working on a project that is using
> the Motorola Coldfire MCF5282 which has an I2C 
> module to talk to three DS1731's.
> 
> We are using uClinux (2.4.22) and it looks like
> I will need to develop an I2C driver to take 
> advantage of the I2C module.
> 
> I've only been working with linux for 6 months
> now and this will be my first linux driver, sooo
> from what I have seen, it should be a very easy
> change from the DS1621 to the DS1731, but I feel
> overwhelmed with options regarding the MCF5282 
> algorithm and adapter code. The h/w module 
> provides the I2C bus access so I would think it 
> should be fairly straight forward? Is there a 
> good example or skeleton to work from?
> 
> Any help or direction you can provide will be
> greatly appreciated.
> 
> TIA,
> 
> Bill Hull
> Senior Software Engineer
> Synchrony, Inc.
> 6410 Commonwealth Drive
> Roanoke, VA 24090
> 540-989-1541
> bill.hull@yahoo.com
> 
