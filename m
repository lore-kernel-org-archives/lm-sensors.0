From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 24 Apr 2013 05:43:51 +0000
Subject: Re: [lm-sensors] [PATCHv1 3/3] hwmon: Add DT documentation for g762 driver
Message-Id: <87r4i0fppk.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
	<6ee748f450ba2a80c87aba08c0672105e2800f93.1366753420.git.arno@natisbad.org>
	<20130423222305.GD13884@titan.lakedaemon.net>
In-Reply-To: <20130423222305.GD13884@titan.lakedaemon.net> (Jason Cooper's
	message of "Tue, 23 Apr 2013 18:23:05 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Simon Guinot <simon.guinot@sequanux.org>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>

Hi Jason,

Jason Cooper <jason@lakedaemon.net> writes:

>> +Example g762 node:
>> +
>> +   g762: g762@3e {
>> +        compatible = "gmt,g762";
>> +   	reg = <0x3e>;
>> +   	pwm_mode = <1>;      /* closed-loop control */
>> +   	pwm_enable = <2>;    /* PWM mode */
>> +   	pwm_freq = <8192>;   /* PWM reference clock freq */
>> +   	fan_pulses = <2>;    /* 2 pulses per rev */
>> +   	fan_div = <2>;       /* fan clock divisor */
>> +   	fan_target = <2000>; /* target fan speed at 2000 RPM */
>> +        fan_gear_mode = <0>; /* default */
>> +        fan_startv = <1>;    /* default */
>> +        pwm_polarity = <0>;  /* default */
>> +   };
>
> I was just giving this quick overview and noticed that you have
> leading whitespace issues in the above block...

Will fix that in next round. Sorry for that and thanks for your time.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
