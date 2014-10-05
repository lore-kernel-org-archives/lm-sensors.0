From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 05 Oct 2014 00:13:53 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/4] hwmon: ltc2978: device tree bindings documentation
Message-Id: <54308D41.9070806@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com> <1412275071-6417-2-git-send-email-atull@opensource.altera.com> <20141003122736.GH26643@leverpostej> <542EDCDB.6040406@roeck-us.net> <20141003231334.GA4609@sirena.org.uk> <542F2FE3.60507@roeck-us.net> <20141004095349.GB4609@sirena.org.uk>
In-Reply-To: <20141004095349.GB4609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "atull@opensource.altera.com" <atull@opensource.altera.com>, "jdelvare@suse.de" <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "delicious.quinoa@gmail.com" <delicious.quinoa@gmail.com>, "dinguyen@opensource.altera.com" <dinguyen@opensource.altera.com>, "yvanderv@opensource.altera.com" <yvanderv@opensource.altera.com>

On 10/04/2014 02:53 AM, Mark Brown wrote:
> On Fri, Oct 03, 2014 at 04:23:15PM -0700, Guenter Roeck wrote:
>> On 10/03/2014 04:13 PM, Mark Brown wrote:
>
>>> Nope, nothing to do with regulator that I'm aware of and I've not seen
>>> any examples (but I don't tend to review users too often).
>
>> Many examples, really. Just picking one.
>
>> Documentation/devicetree/bindings/mfd/tps6507x.txt
>
> OK, that's not an actual DTS...  I'm not seeing anything in the code.
>
>> 	regulators {
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>> 		...
>
>> This also uses the reg property for the regulator index
>> (without explaining it further). Seems to be pretty common.
>
> If it's doing that it's nothing to do with the regulator API.
>
Since the code does not use those values either, presumably they don't have
to be specified in the first place. I'll test that with a real system
next week.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
