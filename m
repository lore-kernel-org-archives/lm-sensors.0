From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 03 Oct 2014 23:23:15 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/4] hwmon: ltc2978: device tree bindings documentation
Message-Id: <542F2FE3.60507@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com> <1412275071-6417-2-git-send-email-atull@opensource.altera.com> <20141003122736.GH26643@leverpostej> <542EDCDB.6040406@roeck-us.net> <20141003231334.GA4609@sirena.org.uk>
In-Reply-To: <20141003231334.GA4609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "atull@opensource.altera.com" <atull@opensource.altera.com>, "jdelvare@suse.de" <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "delicious.quinoa@gmail.com" <delicious.quinoa@gmail.com>, "dinguyen@opensource.altera.com" <dinguyen@opensource.altera.com>, "yvanderv@opensource.altera.com" <yvanderv@opensource.altera.com>

On 10/03/2014 04:13 PM, Mark Brown wrote:
> On Fri, Oct 03, 2014 at 10:28:59AM -0700, Guenter Roeck wrote:
>> On 10/03/2014 05:27 AM, Mark Rutland wrote:
>
>>>> +Optional properties:
>>>> + Name of the optional regulator subnode must be "regulators".
>>>> +  - #address-cells must be 1.
>
>>> What's the single address cell used for?
>
>> I think this is required by the regulator bindings.
>> Other regulators use the same, though they don't typically
>> mention it in the properties list but only in the examples.
>
> Nope, nothing to do with regulator that I'm aware of and I've not seen
> any examples (but I don't tend to review users too often).
>

Many examples, really. Just picking one.

Documentation/devicetree/bindings/mfd/tps6507x.txt

	regulators {
                 #address-cells = <1>;
                 #size-cells = <0>;
		...

This also uses the reg property for the regulator index
(without explaining it further). Seems to be pretty common.

Guenter

>>> Mark, what's the preferred scheme for identifying regulators in a
>>> container node?
>
>>>> +  - regulator-name: arbitrary name for regulator
>
>>> Drop the 'aribtarary'. Either this should be the name of the regulator
>>> on the board, or it shouldn't be necessary.
>
>> Not sure if it even needs to be documented here. It is already documented
>> in Documentation/devicetree/bindings/regulator/regulator.txt.
>
> Document by reference then?  It really should be the name of the supply
> provided by the regulator, that wording is probably good.  Given that
> it's a standard regulator property I'd not document it here at all, just
> refer to the generic bindings and say any suitable properties there can
> be used.
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
