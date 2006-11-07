From: bsapp@lanl.gov (Benjamin Sapp)
Date: Tue, 07 Nov 2006 14:53:13 +0000
Subject: [lm-sensors] DS2321 guidance
Message-Id: <200611071505.kA7F5WaS011759@godiva.ta-18.lanl.gov>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I would like to get the DS2321 Real time clock to work with 
lm-sensors.  The DS2321 is very similar to the DS1307.  In fact the first 
six bytes are identical.  Where the DS1307 has NVRAM, the DS2321 has no ram 
and instead has a temperature sensor.   My current setup is an i.MX21 ARM 
processor with integrated I2C master/slave controller with appropriate 
drivers from Freescale connected to the DS2321.  From looking at the kernel 
source with some working I2C peripherals and the source to lm-sensors it 
seems clear that the 2.4.20 kernel I was given had an older version of 
lm-sensors integrated into it.  My thinking was to take the DS1307 and copy 
it by hand into the kernel and then modify it as appropriate.  So if you 
could first comment on whether my plan seems sensible I'd be 
grateful.  Second, how is the ds1307 supposed to be accessed?  In the 
documentation for the chip it claims that it works with frodo-nvram and 
frodo-rtc.  What are frodo-nvram and frodo-rtc?

Thanks,
Ben Sapp.



