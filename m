From: atull <atull@opensource.altera.com>
Date: Wed, 08 Oct 2014 16:12:29 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/4] hwmon: ltc2978: device tree bindings documentation
Message-Id: <alpine.DEB.2.02.1410081103110.18439@atx-linux-37>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com> <1412275071-6417-2-git-send-email-atull@opensource.altera.com> <20141006172845.GA21902@roeck-us.net>
In-Reply-To: <20141006172845.GA21902@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Mon, 6 Oct 2014, Guenter Roeck wrote:

> On Thu, Oct 02, 2014 at 01:37:48PM -0500, atull@opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add device tree bindings documentation for ltc2978.
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > ---
> > v2: clean whitespace
> > ---
> >  .../devicetree/bindings/hwmon/ltc2978.txt          |   41 ++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> > new file mode 100644
> > index 0000000..b2d9c4d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> > @@ -0,0 +1,41 @@
> > +ltc2978
> > +
> > +Required properties:
> > + - compatible: one of: ltc2974, ltc2977, ltc2978, ltc3880, ltc3883, ltm4676
> > + - reg: I2C address
> > +
> > +Optional properties:
> > + Name of the optional regulator subnode must be "regulators".
> 
> This is currently a problem. The regulator core trats it as mandatory,
> meaning I get error messages such as
> 
> ltc2978 5-005e: Failed to find regulator container node
> 
> if not specified. We'll have to sort out with the regulator core how this should
> be handled.
> 
> > +  - #address-cells must be 1.
> > +  - #size-cells must be 0.
> > +
> 
> Checking this out, those do not seem to be necessary.

I just tried it, and don't see a need for it myself.
	 
> 
> > + For each regulator:
> > +  - reg: regulator number
> 
> This does not seem to be necessary either.

Same here.  For some reason I thought they were required.  
I'll take them out of the bindings doc.

> 
> > +  - regulator-compatible: must be vout_en<regulator number> such as vout_en3
> > +    valid range is:
> > +      ltc2977, ltc2978 : vout_en0 - vout_en7
> > +      ltc2974          : vout_en0 - vout_en3
> > +      ltc3880, ltm4676 : vout_en0 - vout_en1
> > +      ltc3883          : vout_en0 only
> 
> Besides the unnecessary _en,

I don't mind taking out the '_en'.  I was trying to name these
after pin names on the device.  I thought that was the norm.
If someone adds voltage support later, that will look even
weirder, so I agree that should change.

> this is a problem if there is more than one
> supported chip in the system, if DEBUG_FS is enabled, and if names are not
> specified in the devicetree file. I get a lot of error messages in a
> system with a large number of LTC2978 chips.
> 
> vout3: Failed to create debugfs directory
> vout4: Failed to create debugfs directory
> vout5: Failed to create debugfs directory
> vout6: Failed to create debugfs directory
> vout7: Failed to create debugfs directory
> vout2: Failed to create debugfs directory
> vout3: Failed to create debugfs directory
> 
> and so on (40+ times in my system). We will have to find a solution for this
> problem.

Note that whatever name is here is going to be the compatible
string for this particular regulator output in the DT.

It seems like this can't be the only case of this in the kernel.
I imagine there are lots of boards with multiple regulators but
no regulator info specified. I'll have to dig a bit to see why
this isn't an issue for other regulator drivers.

> 
> I also get
> 
> vout7: no parameters
> 
> for each regulator which is a bit annoying with 50+ of those regulators
> in the system.

Yes I see that and tried to make it stop (but couldn't).  It is not
really helpful information.

Alan

> 
> Guenter
> 
> > +  - regulator-name: arbitrary name for regulator
> > +
> > +Example:
> > +ltc2978@5e {
> > +	compatible = "ltc2978";
> > +	reg = <0x5e>;
> > +	regulators {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		vdacp0_reg: regulator@0 {
> > +			reg = <0>;
> > +			regulator-compatible = "vout_en0";
> > +			regulator-name = "FPGA-2.5V";
> > +		};
> > +		vdacp2_reg: regulator@2 {
> > +			reg = <2>;
> > +			regulator-compatible = "vout_en2";
> > +			regulator-name = "FPGA-1.5V";
> > +		};
> > +	};
> > +};
> > -- 
> > 1.7.9.5
> > 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
