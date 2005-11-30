From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 30 Nov 2005 23:11:10 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <438E2374.6030003@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,


> Now... I have to admit I am out of ideas at this point. Maybe you can try
> enabling kernel debugging (Detect Soft Lockups, Spinlock debugging...)
> and see if something shows. But that's a blind shot.

Never give up, never surrender :) Lets focus on SMI. This should disable
the SMI from this chip. So we can at least eliminate this source.
OVT# is also unused so this should point if you have HW or SW (bus driver)
problem.

Please can you try with this sequence, which is same except of new first
line.

Quoting Jean:

You can use the i2cset program to write to the W83792D chip directly. You
can try using the following commands in your script, without loading the
w83792d driver. Let us know if it hangs of not.

i2cset -y 0 0x2c 0x40 0x1  # DISABLE SMI
i2cset -y 0 0x2c 0x2b 0xff # in0_max
i2cset -y 0 0x2c 0x2c 0x00 # in0_min
i2cset -y 0 0x2c 0x2d 0xff # in1_max
i2cset -y 0 0x2c 0x2e 0x00 # in1_min
i2cset -y 0 0x2c 0x2f 0xff # in2_max
i2cset -y 0 0x2c 0x30 0x00 # in2_min
i2cset -y 0 0x2c 0x31 0xff # in3_max
i2cset -y 0 0x2c 0x32 0x00 # in3_min
i2cset -y 0 0x2c 0x33 0xff # in4_max
i2cset -y 0 0x2c 0x34 0x00 # in4_min
i2cset -y 0 0x2c 0x35 0xff # in5_max
i2cset -y 0 0x2c 0x36 0x00 # in5_min
i2cset -y 0 0x2c 0x37 0xff # in6_max
i2cset -y 0 0x2c 0x38 0x00 # in6_min
i2cset -y 0 0x2c 0xb4 0xff # in7_max
i2cset -y 0 0x2c 0xb5 0x00 # in7_min
i2cset -y 0 0x2c 0xb6 0xff # in8_max
i2cset -y 0 0x2c 0xb7 0x00 # in8_min
i2cset -y 0 0x2c 0x39 0x7f # temp1_max
i2cset -y 0 0x2c 0x3a 0x00 # temp1_min
i2cset -y 0 0x2c 0xc3 0x7c # temp2_max_hyst
i2cset -y 0 0x2c 0xc5 0x7f # temp2_max
i2cset -y 0 0x2c 0xcb 0x7c # temp3_max_hyst
i2cset -y 0 0x2c 0xcd 0x7f # temp3_max
i2cset -y 0 0x2c 0x3b 0xff # fan1_min
i2cset -y 0 0x2c 0x3c 0xff # fan2_min
i2cset -y 0 0x2c 0x3d 0xff # fan3_min
i2cset -y 0 0x2c 0xbb 0xff # fan4_min
i2cset -y 0 0x2c 0xbc 0xff # fan5_min
i2cset -y 0 0x2c 0xbd 0xff # fan6_min
i2cset -y 0 0x2c 0xbf 0xff # fan7_min

This should completly disable the SMI.	Lets see how it works :)

Regards
Rudolf
