From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 02 Jun 2013 21:36:28 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <87ppw442lf.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
	<b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
	<20130531221616.GG7626@kw.sim.vm.gnt> <87fvx1pwrl.fsf@natisbad.org>
	<87ip1w8qix.fsf@natisbad.org> <20130602203553.GA7920@roeck-us.net>
In-Reply-To: <20130602203553.GA7920@roeck-us.net> (Guenter Roeck's message of
	"Sun, 2 Jun 2013 13:35:53 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Simon Guinot <simon.guinot@sequanux.org>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> writes:

> On Sun, Jun 02, 2013 at 05:45:58PM +0200, Arnaud Ebalard wrote:
>> Hi,
>> 
>> >> I haven't noticed this issue while testing your v1 patch series because
>> >> at the time I was using a board with an U-Boot modified by LaCie. This
>> >> last sets the set_cnt register to 0 while U-Boot mainline don't.
>> >> Actually, the 2Big fan is not configured nor even started by U-Boot
>> >> mainline. I have to fix this but maybe that something can be done in
>> >> the g762 Linux driver too ?
>> 
>> At the moment, DT bindings and platform_data structure both allow
>> setting an initial fan_target value. I could add a 'pwm' binding for DT  
>> and an assoicated field in platform_data to allow passing an initial
>> value so that maintainers of platforms with a 2 wire fan (open loop) can
>> still make the fan somewhat rotate at boot.
>> 
> Devicetree properties are supposed to describe the system, not its configuration.
> There are exceptions, but I don't recall seeing a case where a parameter
> can be set both with devicetree properties and sysfs attributes.
>
> Before going further on this, we will need to have an ack from devicetree
> maintainers which specifically permits your dual-configuration approach.
> Even with that, you'll still have convince me that you need both (while
> so far no other driver needed it).

If you are not convinced yet, what I can do is remove the code in question
in a v4 and work on remaining issues (e.g. platform data init, fan_target
and pwm1 access for closed-loop) based on your feedback. If during the
process or after inclusion of this minimal version someone brings new
arguments to add the code back, this should be fairly easy to do.

Thanks for your time and patience dealing with me.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
