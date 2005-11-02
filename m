From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 02 Nov 2005 00:05:53 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <4367F4D3.7080204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For the record, I'm a teacher in electrical engineering and computer
> science at a Dutch university.

Cool. Wee need such persons to help us exactly with ADC problems ;)

> 
> At first I had the same tought process as you and I too thought that the
> uGuru is most likely hooked up to a 3.5v voltage reference. But there
> are a number of reasons why I'm not so sure:
> 
> The W83L950D has only 8 analog inputs, but the uGuru has 16. So somehow
> Abit is doing some trickery to get more analog inputs, they could be
> using the 8 comparator inputs, with one of the DA outputs hooked up to
> the comparator reference pin, and using SAR to build another 8 AD inputs
> out of this.

Hmm quite clever.

> BTW pin P3REF is the comparator reference not the AD/DA reference. the
> VREF pin (72) is the AD/DA reference. Also P3REF is pin 58, not 50.

Aha ok

> They could however also be using one or more external sensor IC's hooked
> up to one of the 2 i2c/smbus controllers which are onboard the W83L950D.
> In this case the reference voltage hooked up to the W83L950D is
> irrelevant (or atleast irrelevant for some of the inputs).
> 
> Also if I we're to design the sensor part of a mainboard I would want to
> have a cheap reference voltage with a low temperature drift, thus I
> would use an of the shelf component. These however do not come in a 3.5
> volt variant, atleast not from the worldst 2 biggest reference voltage
> IC suppliers, see:
> http://para.maxim-ic.com/compare.asp?Fam=Volt_Ref&Tree=References&HP=References.cfm&ln> 
> http://www.analog.com/en/subCat/0,2879,769%255F838%255F0%255F%255F0%255F,00.html
> 
> 
> So a reference voltage of 3.5 volt is not likely, assuming that Abit
> doesn't want to build a descrete reference voltage source themselves, or
> use an expensive programmable one. Also note that a simple zenerdiode
> setup will not suffice since its temperature drift is to high, (at least
> higher then what I've seen with my mb sofar).

Thank you for your analysis. However chip makers do create custom IO devices or custom modifications for MB manufacturers (big customers?)

> Also you assume that the other mutipliers used are based on round
> dividers of the input voltage, but if that where the case then the
> 0-6.25 volt would be 0-7 volt which is a rather big error.
> 
> Last, the uGuru is a microcontroller and could do some scaling itself. I
> know this is the case for temperature sensors, since the register value
> equals the temperature in degrees celcius here, so most likely the uGuru
> has already done conversion here.

Yes true.

> So in short, we don't even now which inputs if any are used, and we
> don't know what kindoff conversions if any are already done by the
> uGuru. And since I'm not planning on reverse engineering the layout of a
> 6 layer print we will probably never know.

I was wondering to read the uGUru program out of it. It seems it can be possible. And then read the x51 assembly.

> The current uGuru driver is based on software reverse-engineering, not
> hardware reverse-engineering. One of the reasons for this is that the
> hardware used is programmable, so we will probably never know what is
> going on inside. Another reason is that its a lot easier and safer.

Agree

> I can however modify the driver to always scale all analog inputs to
> 0-3.5 volts and modify sensors.conf accordingly if that makes you happier.

This is not what makes us happy. We simply need SAME interface for every possible chip that provides voltages. We dont
want any "if uguru" in software libraries.

Please convert it so it gives out some values in mV as interface request it.

Thanks,

Regards
Rudolf
