From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 20 Jun 2013 19:10:22 +0000
Subject: Re: [lm-sensors] [PATCHv7 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <87ehbwvbs1.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ip19sxmd.fsf@natisbad.org>
	<20130620013823.GC29521@roeck-us.net>
In-Reply-To: <20130620013823.GC29521@roeck-us.net> (Guenter Roeck's message of
	"Wed, 19 Jun 2013 18:38:23 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> writes:

> On Wed, Jun 19, 2013 at 09:34:34PM +0200, Arnaud Ebalard wrote:
>> 
>> GMT G762/763 fan speed PWM controller is connected directly to a fan
>> and performs closed-loop or open-loop control of the fan speed. Two
>> modes - PWM or DC - are supported by the chip. Introduced driver
>> provides various knobs to control the operations of the chip (via
>> sysfs interface). Specific characteristics of the system can be passed
>> either using board init code or via DT. Documentation for both the
>> driver and DT bindings are also provided.
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>
> Couple of additional nitpicks plus a bug.
>
>> +static void g762_of_clock_disable(struct i2c_client *client)
>> +{
>> +	struct g762_data *data = i2c_get_clientdata(client);
>> +
>> +	if (data->clk)
>> +		return;
>
> Guess this should be 
> 	if (!data->clk)
> 		return;
>
> Small but significant difference ...

I am going to find me a hole to hide in. Thanks for catching
this. Resending a v8 after fixing it and the other points you
pointed.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
