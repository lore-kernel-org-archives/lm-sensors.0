From: dfisher@as.arizona.edu (don fisher)
Date: Wed, 21 Sep 2005 02:41:45 +0000
Subject: [lm-sensors] Tyan Thunder K8W S2885
Message-Id: <4330AC00.50701@as.arizona.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

The Tyan S2885 contains an ADT7463 monitor IC and a Winbond W83627hf
SuperIO chip. The BIOS displays 3 temperatures, 6 fan speeds, VCORE
AND DIMM voltages for each CPU and 4 more voltages on the board )(8
voltages total).

Since the ADT chip, depending on configuration, has just 4 tach inputs
  and it appears less than 8 voltage inputs I have assumed the
W83627h7 is also being employed (the user manual indicates fan 5 is
pin 113 and fan 6 is connected to pin 112).

When I run sensors-detect both devices, along with the eeprom, are
detected.

     Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')

   * Bus `SMBus AMD8111 adapter at 50e0' (Algorithm unavailable)
     Busdriver `i2c-amd756', I2C address 0x2e
     Chip `Analog Devices ADM1027, ADT7460 or ADT7463' (confidence: 8)

   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

When I execute sensors, all of my dram chips are listed followed by
the output from adt7463-i2c-0-2e.

There is no output from the W83627hf device. I build a kernel with
embedded device drivers, with no change. I even forced the ISA bus
back on with no positive results (I realize ISA is mapped memory, but
when I did a depmod on the W83627hf driver, the isa bus was not
listed. It was a long shot).

How do I do to have sensors generate output from both chips. I can
deduce from the corresponding BIOS readings what the voltages etc.
correspond to.

Thanks
don

-- 
-------------------------------------------------------------------
|    Don Fisher				  dfisher@as.arizona.edu  |
|    Steward Observatory		  			  |
|    933 N. Cherry Ave.    		  VOICE: (520)888-7613	  |
|    University of Arizona		                          |
|    Tucson, AZ  85721                				  |
-------------------------------------------------------------------


