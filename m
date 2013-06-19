From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 19 Jun 2013 20:15:56 +0000
Subject: Re: [lm-sensors] [RESEND, PATCHv6 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <8761x9svpf.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87sj0jhuhn.fsf@natisbad.org>
	<20130617101948.GY7626@kw.sim.vm.gnt>
In-Reply-To: <20130617101948.GY7626@kw.sim.vm.gnt> (Simon Guinot's message of
	"Mon, 17 Jun 2013 12:19:48 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Simon,

Simon Guinot <simon.guinot@sequanux.org> writes:

> I have tested this patch on my 2Big Network v2 board.
>
> Sometimes I get a weird "No such device" error while reading or writing
> the hwmon sysfs attributes. For example:
>
> # cat pwm1
> cat: read error: No such device
> # cat pwm1
> 0

Weird, I cannot reproduce that at all on my ReadyNAS Duo v2.

> Note, that if the same command is executed again (just after the faulty
> one), then it will succeed most of the time. The errors seems to happen
> quite randomly and not very often. I'd say one time over ten tries.
> I suppose this error is now visible due to the enhanced error path in
> g762_update_client. It looks like we learn something by checking the
> return value for i2c_smbus_read_byte_data :)
>
> Except that, all is working as expected. This new version fixes
> effectively open-loop driving when the set_cnt register is set to 0xff.
>
> Also I am planning (hopefully this Wednesday) to test your patch on my
> 5Big Network v2 board. This last also embed a g762 controller but with a
> three wires fan instead. Then, I should be able to test the closed-loop
> mode behaviour.

Thanks for your tests, Simon.

Cheers,

a+ 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
