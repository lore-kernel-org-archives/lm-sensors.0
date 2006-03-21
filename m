From: swsnyder@insightbb.com (Steve Snyder)
Date: Tue, 21 Mar 2006 17:58:03 +0000
Subject: [lm-sensors] lm87 on kernel 2.6.9: kinda-sorta working. What
Message-Id: <200603211258.04132.swsnyder@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603211249.43224.swsnyder@insightbb.com>
In-Reply-To: <200603211249.43224.swsnyder@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops! Forgot to mention that I'm using lm_sensors-2.8.7 for the userspace 
programs.  (Standard with RHEL4).

----------  Forwarded Message  ----------

Subject: lm87 on kernel 2.6.9: kinda-sorta working.  What else is needed?
Date: Tuesday 21 March 2006 12:49 pm
From: Steve Snyder <swsnyder at insightbb.com>
To: lm-sensors at lm-sensors.org

I am attempting to get LM87 support on a RHEL4 kernel.  This kernel,
2.6.9-34.EL, does not include the lm87 driver, so I'm trying to add it
myself.

My desire is to get health information from my Supermicro P3TDLE
M/B (http://www.supermicro.com/products/motherboard/P3/LE/P3TDLE.cfm).

I got the lm87.c from the standard 2.6.10 kernel and simply dropped it
into Red Hat's source tree.  After adding the required normal_i2c_range[]
and normal_isa_range{} references (see below) it built without complaint.
No errors or warnings are seen in the system log at load time, either.

At runtime, though, I get this:

# sensors
lm87-i2c-0-2e
Adapter: SMBus PIIX4 adapter at 0580
ERROR: Can't get IN1 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
fan1:     5153 RPM  (min = 2848 RPM, div = 2)
fan2:     5153 RPM  (min = 2848 RPM, div = 2)
temp1:       +33?C  (low  =    +0?C, high =   +50?C)
ERROR: Can't get TEMP2 data!

Yes, this is a dual-CPU board, and the single temperature shown is
reasonably close to the values reported by the BIOS in the BIOS
setup menu.

This are the 2 lines I added to the 2.6.10 version of lm87.c to pacify
the build complaints:

  static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
  static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };

So now the full set of address declarations look like this:

  static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END
 }; static unsigned short normal_i2c_range[] = { I2C_CLIENT_END }; static
 unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
  static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };

Any advice out there on what else is needed to get LM87 support with this
2.6.9 (+ backported tweaks and fixes) kernel?

Thanks.

-------------------------------------------------------

