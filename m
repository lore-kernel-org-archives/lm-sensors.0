From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Mon, 05 Mar 2012 03:09:50 +0000
Subject: Re: [lm-sensors] Interpreting lm-sensors's output
Message-Id: <jwvfwdn92cd.fsf-monnier+INBOX@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
In-Reply-To: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> >> OT1H the "high=3D70" and "crit=3D100" would seem to give me the answe=
r, but
>> >> OTOH I don't know whether I can trust them (actually, I hope some of
>> >> the output is "wrong" since the sensor readings go up routinely to 80=
=B0
>> >> during long compilations).
>> > They are correct and you should trust them.  If you reach 80=B0C then =
you
>> > probably need better thermal dissipation or a different CPU / graphics
>> > power management strategy.
>> The thing that puzzles me is that this low-power mini-ITX board (fanless
>> Brazos E350) is in a full-size ATX chassis (Antec Sonata) which
>> previously held an high-power Athlon X2 board (first with the stock
>> AMD heatsink+fan, and then later with a monster fanless heatsink), so
>> I have a hard time understanding how this low-power board can heat up
>> worse than the other one in the exact same context (same chassis,
>> power-supply, devices, system fan spinning at the same speed, ...).
>> The Athlon X2 barely reached 70=B0C in the hottest part of the summer,
>> under full load.
> Comparing a system with a CPU fan with one without doesn't necessarily
> make a lot of sense. Sure, the chassis and system fan are the same, but
> when you had a CPU fan it was the main factor for determining the CPU
> temperature. Now the airflow in the chassis has become the main factor.

As mentioned, I've used my Athlon X2 both with a CPU fan and without
(using a larger heatsink).  But I guess you're right that maybe the
airflow just isn't good enough on the heatsink (the Athlon X2's
heatsink was so massive that the airflow had to go through it, whereas
the one on my new AMD E350 is much smaller, so it's quite likely that
most of the airflow goes past it).

> Also note that the values reported by k8temp / k10temp are essentially
> relative values in pseudo-degrees C, so comparing them from one CPU
> model to another is not meaningful either. What is meaningful is the
> difference between the current temperature and the high (or critical)
> limit. That is, the thermal margin.

Yes, knowing that I can trust the `high' and `crit' values is what
I needed to hear.

>> OK, I finally added "acpi_enforce_resources=3Dlax" and loaded the it87
> Not necessarily a good idea in the long run, but I'll assume you know
> what you're doing.

No, I don't actually know what I'm doing (only have a vague idea, like
enough to know it's not a good idea), but it's the only way to access
the it87 sensors right now it seems (for lack of a corresponding ACPI
driver).

> Yes, I would assume the same, although it's strange that it is a
> thermal diode, usually a thermistor is used for motherboard
> temperature. You should check what the BIOS has to say with regards to
> temperatures. If the motherboard really runs at 30=B0C then it seems
> reasonable.

The BIOS only reports one temperature measurement which hovers around
45=B0C (sounds lowish for the k10 sensor, and very high for the it87
sensor, so all in all, I'd guess it's the k10temp sensor, unless it's
a completely different one which lm-sensors doesn't know about).


        Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
