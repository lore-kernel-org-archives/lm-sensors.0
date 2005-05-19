From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: LM87.c and kernel 2.6.8
Message-Id: <200408191209.19658.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am trying to use the lm87 support that I have been successfully using 
under 2.6.7 for a while now with 2.6.8.

When I try to build the kernel I get the following errors:-

  CC [M]  drivers/i2c/chips/lm87.o
drivers/i2c/chips/lm87.c:341: error: parse error before "static"
drivers/i2c/chips/lm87.c:342: error: parse error before "static"
drivers/i2c/chips/lm87.c:343: error: parse error before "static"
drivers/i2c/chips/lm87.c:344: error: parse error before "static"
drivers/i2c/chips/lm87.c:345: error: parse error before "static"
drivers/i2c/chips/lm87.c:346: error: parse error before "static"
drivers/i2c/chips/lm87.c:539: error: parse error before "static"
drivers/i2c/chips/lm87.c:540: error: parse error before "static"
drivers/i2c/chips/lm87.c: In function `lm87_detect':
drivers/i2c/chips/lm87.c:867: error: `dev_attr_in0_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:867: error: (Each undeclared identifier is reported 
only once
drivers/i2c/chips/lm87.c:867: error: for each function it appears in.)
drivers/i2c/chips/lm87.c:870: error: `dev_attr_in1_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:873: error: `dev_attr_in2_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:876: error: `dev_attr_in3_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:879: error: `dev_attr_in4_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:882: error: `dev_attr_in5_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:894: error: `dev_attr_fan1_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c:895: error: `dev_attr_fan2_min' undeclared (first use 
in this function)
drivers/i2c/chips/lm87.c: At top level:
drivers/i2c/chips/lm87.c:341: warning: `show_in0_min' defined but not used
drivers/i2c/chips/lm87.c:341: warning: `set_in0_min' defined but not used
drivers/i2c/chips/lm87.c:342: warning: `show_in1_min' defined but not used
drivers/i2c/chips/lm87.c:342: warning: `set_in1_min' defined but not used
drivers/i2c/chips/lm87.c:343: warning: `show_in2_min' defined but not used
drivers/i2c/chips/lm87.c:343: warning: `set_in2_min' defined but not used
drivers/i2c/chips/lm87.c:344: warning: `show_in3_min' defined but not used
drivers/i2c/chips/lm87.c:344: warning: `set_in3_min' defined but not used
drivers/i2c/chips/lm87.c:345: warning: `show_in4_min' defined but not used
drivers/i2c/chips/lm87.c:345: warning: `set_in4_min' defined but not used
drivers/i2c/chips/lm87.c:346: warning: `show_in5_min' defined but not used
drivers/i2c/chips/lm87.c:346: warning: `set_in5_min' defined but not used
drivers/i2c/chips/lm87.c:539: warning: `show_fan1_min' defined but not used
drivers/i2c/chips/lm87.c:539: warning: `set_fan1_min' defined but not used
drivers/i2c/chips/lm87.c:540: warning: `show_fan2_min' defined but not used
drivers/i2c/chips/lm87.c:540: warning: `set_fan2_min' defined but not used
make[4]: *** [drivers/i2c/chips/lm87.o] Error 1

I guess something has changes in the i2c support in 2.6.8 that is causing,
has anyone got any idea what I need to do to fix it?

Is there any chance (once this compile problem has been fixed) if getting
the lm87 support submitted for inclusion in the official kernel?

Thanks in advance

David
