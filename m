From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Fri, 22 Jun 2012 12:00:33 +0000
Subject: Re: [lm-sensors] Configuration for EL620-C motherboard
Message-Id: <4FE45E61.7010601@sat.dundee.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE232BE.7060409@sat.dundee.ac.uk>
In-Reply-To: <4FE232BE.7060409@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear Jean,
> Wow, I thought ISA slots died 10 years ago! I'm a bit curious what kind
> of cards you plug in them and if they work OK with recent Linux
> kernels. Some times ago, Alan Cox wanted to kill ISA support altogether!

ISA has vanished from most server/desktop PCs in the last 10 years but=20
is still seen in industrial control applications due to the legacy (and=20
often bespoke) hardware and software used.

Usually to get ISA slots now you need to look at 19" rack-mount PCs=20
using a "single board computer" (SBC) that plugs in to backplanes with=20
various combinations of PCI & ISA slots.

Even some 'new' standards like PC/104 are really ISA with a different=20
connector!

However, the normal ATX style of motherboard provided by the EL620-C was=20
better overall value for our application as we only need 2*ISA and 1*PCI=20
cards, and offered us the speed of a Core 2 Quad-Q8400 processor (not=20
quite up to date, but a generation or two ahead of they typical SBC)=20
along with dual RS232 and gigabit Ethernet ports.

In our case it is to support custom ISA cards we designed for satellite=20
reception antenna control 21 years ago, and the DOS-based software still=20
works reliably using dosemu on Linux as that allows controlled direct=20
hardware access (for I/O and IRQ at least) just as DOS used to, but with=20
all of the other benefits of network access and security.

If it works why change it!

> I had limited experience with DFI so far, good to know they have great
> support.

I was surprised to get a decent answer in under a day, I wish more=20
companies were like that!

> Overall it looks very good. Thanks for your contribution, I have added
> it to our wiki:
> http://www.lm-sensors.org/wiki/Configurations/DFI/EL620-C

Thanks.

>> # We need to set voltage limits. Note you may need to adapt in0 dependin=
g on your CPU
>>      set in0_min   0.9
>>      set in0_max   1.7
>
> 1.7 seems a little high for a Socket 775 CPU. I don't think any of them
> can take more than 1.5 V. OTOH some models can go as low as 0.85 V.

The motherboard takes a range of CPUs so it was a guess, we were running=20
at 1.1V.

Looking at the compatibility list:

http://img.dfi.com/Upload/CatalogElement/ACP/ATX-EL620-C-Compatibility-List=
-111025.pdf

The voltages range from 0.85V to 1.5V as you say, so maybe that should=20
be changed to be 0.80 to 1.55V?

>> # DDR3 voltage ranges?
>>      set in5_min   1.30
>>      set in5_max   1.65
>
> According to Wikipedia quoting JEDEC, "1.575 volts should be considered
> the absolute maximum when memory stability is the foremost
> consideration." Which incidentally is 1.5V + 5%, so in line with ATX12V
> rules. For the lower end, it depends if the board supports low-voltage
> (1.35V) DDR3.

This was based on the info from the Crucial site when looking for 2GB=20
DDR3 to match:

"Voltage refers to the power consumed by a module. In the past, most=20
DDR3 memory voltage ranged from 1.5 - 1.65v. More recently, dual=20
1.35/1.5 voltage modules came available at Crucial.com.  While the lower=20
voltage memory has some advantages over high voltage (namely lower power=20
consumption), your system must support it in order to realize the benefits."

I guess nobody is going to over-clock an industrial PC so maybe it would=20
be sensible to lower the upper limit a little, perhaps to 1.58V?

>> # Fans
>>     label fan1		"System fan"
>>     label fan2		"CPU Fan"
>>     label fan3		"2nd fan"
>
> This is a rather poor label. Either don't give it a label at all, or
> use the connector name on the board, or a name describing the intended
> usage for the extra fan (e.g. "Front fan", "Rear fan", "PSU fan"...)

The motherboard actually has two 3-pin sockets labelled SYSTEM_FAN and=20
2nd_FAN respectively!

>> # Fan minimums, disable fan1 & fan2 as a case fan is not always connected
>
> I guess you mean "fan1 & fan3"?

Yes, just a typo.

>> # Temperatures. Can we assume temp2 limit for CPU is set by BIOS?
>
> Very likely, yes. You may even be able to chose the limit in the BIOS
> setup screens.

I suspect so, but as the current PC is in use I can't check this until=20
the remainder are ready. When I checked it before creating the sensors=20
config file it read:

temp1:        +28.0=B0C  (high =3D -29.0=B0C, hyst =3D +38.0=B0C)  sensor =
=3D thermistor
temp2:        +23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
temp3:        +36.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor

While temp1 clearly has incorrect limits, the values of 80C & 75C for=20
the temp2 =3D CPU is not unreasonable.

Regards,
Paul
--=20
Dr. Paul S. Crawford
Satellite Station
Dundee University
Small's Wynd, Dundee,
DD1 4HN, U.K.
Tel: +44 (0)1382 38 4687
Email: psc@sat.dundee.ac.uk
The University of Dundee is a Scottish Registered Charity, No. SC015096


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
