From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Query: pentium II LM75 for CPU temp
Message-Id: <ic0b61hupih5rkn7m2ctd3cg1n4jc52vag@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

lm_sensors web site states boxed pentiumII processors have an 
LM75 near CPU to measure CPU temperature...

So I load the lm75 module, it finds an i2c address but reports 
'3000' for the three temp variables.

But if I run sensors-detect, it does not find anything at the 
same i2c address, no other sensor chips.

I do know the mainboard has a PCA8550 hanging off i2c, but I don't 
think lmsensors bothers with it as it is a 5-bit eeprom mux/latch.

Mainboard is SE440BX-2

Cheers,
Grant.
