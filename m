From: Curt Brune <curt@cumulusnetworks.com>
Date: Wed, 03 Dec 2014 04:12:42 +0000
Subject: [lm-sensors] adt7475 driver: PWM invert configuration bit
Message-Id: <20141203041242.GD11971@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a system where I need to change the "PWM invert" bit (bit 4) in
the PWM configuration register (offset 0x5C).  The description of this
configuration bit from the data sheet:

  This bit inverts the PWM output. The default is 0, which corresponds
  to a logic high output for 100% duty cycle. Setting this bit to 1
  inverts the PWM output, so 100% duty cycle corresponds to a logic
  low output.

I noticed the adt7475.c driver does not expose this bit in sysfs.
Before hacking away I am curious to know why this configuration bit is
not exposed already.  Some reasons I could think of:

- expect the power on default to be correct
- expect some other software (boot loader or BIOS) has already set it
- just never needed it

If it was just never needed then I am proposing to add 3 read/write
files to sysfs:

   pwm1_invert
   pwm2_invert
   pwm3_invert

The values of 0 and 1 would have the same meaning as the "PWM invert"
bit (bit 4) in the PWM configuration register (offset 0x5C).  Any
other value would be treated as -EINVAL.

Cheers,
Curt

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
