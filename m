From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 04 Jun 2013 06:51:45 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <87zjv6z7um.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
	<b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
	<20130531221616.GG7626@kw.sim.vm.gnt> <87fvx1pwrl.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Simon,

arno@natisbad.org (Arnaud Ebalard) writes:

> Regarding your problem, I first started by booting current version of my
> driver on the Duo v2 w/o touching chip registers (only clock reference
> value). This way, I inherit the values installed by (NETGEAR's) u-boot:
>
> $ for k in fan* pwm* ; do echo -n "$k:" ; echo `cat $k `; done
> fan1_alarm:0
> fan1_div:2
> fan1_fault:0
> fan1_input:1807
> fan1_target:1807
> pwm1:221
> pwm1_enable:2        /* closed-loop, i.e. config is done via set_cnt */
> pwm1_mode:1          /* PWM mode */ 
>
> If G762 datasheet is correct, NETGEAR's u-boot alters fan divisor ('01'
> i.e. 2 instead of '00' i.e. 1). It also changes the default mode from
> linear to pwm and sets set_cnt to 34 (255-221). 
>
> Then, I grabbed the GPL sources (5.3.7) of NETGEAR's u-boot and found
> the following in a boot function:
>
>  /* Turn G76x(FAN controller, i2c address 0x3e) on.
>   * The FAN_SET_CNT register's offset is 0x0.
>   * Set [1300(rpm) = 65% = 5a(FAN_SET_CNT)] as default.
>   */
>  unsigned char byte=0x5a;
>  if(i2c_write(0, 0x3e, 0x0, 1, &byte, 1) != 0) 
>    puts ("Error writing the i2c chip : G76x(Fan controller).\n");
>
> AFAICT, this is the only location in the whole source tarball where 0x3e
> reg is modified in an i2c function. 
>
>
> Then, I grabbed the u-boot source code from NETGEAR for ReadyNAS 102
> (Armada-370 based NAS, also using a G762) and it has the following:
>
>  /* Turn G76x(FAN controller, i2c address 0x3e) on.
>   * The FAN_SET_CNT register's offset is 0x0.
>   * Set [1300(rpm) = 65% = 5a(FAN_SET_CNT)] as default.
>   */
>  MV_U8 byte=0x5a;
>  if(i2c_write(0x3e, 0x0, 1, &byte, 1) != 0)
>  	puts ("Error writing the i2c chip : G76x(Fan controller).\n");
>  /* Tune the FAN_STARTV */
>  if (i2c_read(0x3e, 0x5, 1, &byte, 1) != 0)
>  	puts ("Error reading the i2c chip : G76x(Fan controller).\n");
>  byte |= 0x3;
>  if(i2c_write(0x3e, 0x5, 1, &byte, 1) != 0)
>  	puts ("Error writing the i2c chip : G76x(Fan controller).\n");
>  
> In the end, it does not seem NETGEAR's u-boot does some specific things
> except setting a non-zero value to SET_CNT register for the fan to start
> rotating.
>
> BTW, if you wonder why some attributes reported at the beginning have
> different values than the ones in the datasheet (0x5a set in u-boot,
> reading 0x22) although NETGEAR's u-boot code does not seem to tamper
> those, I don't have the answer. 

I was not happy with previous result and did some additional tests.
Between each tests, I did a full power off (halt and removal of power
cable) of the device instead of a simple reboot. With a power off, I
get the following:

fan1_alarm:0
fan1_div:1
fan1_fault:0
fan1_input:1365
fan1_target:1365
pwm1:0
pwm1_enable:2
pwm1_mode:0

Note that fan1_target reflects the fact that set_cnt is 165 (i.e. 255 -
0x5a), which is exactly what NETGEAR's u-boot sets for this reg.

Now, if I do a simple restart, there is some hysteresis which explains
the weird difference in my first test.

Another message follows w/ additional answers to your problem.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
