From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Fri, 23 Mar 2012 13:50:29 +0000
Subject: Re: [lm-sensors] Interpreting lm-sensors's output
Message-Id: <jwvbonnmo0a.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
In-Reply-To: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> >> k10temp-pci-00c3
>> >> Adapter: PCI adapter
>> >> temp1:        +51.5=B0C  (high =3D +70.0=B0C)
>> >>                        (crit =3D +100.0=B0C, hyst =3D +97.0=B0C)
>> [...]
>> >> OT1H the "high=3D70" and "crit=3D100" would seem to give me the answe=
r, but
>> >> OTOH I don't know whether I can trust them (actually, I hope some of
>> >> the output is "wrong" since the sensor readings go up routinely to 80=
=B0
>> >> during long compilations).
>> > They are correct and you should trust them.  If you reach 80=B0C then =
you
>> Just one more question about these numbers: would the same numbers
>> appear under Windows (everything else being "equal")?
> This is impossible to say, I'm afraid.
> First, there are various ways to save power in modern systems, via
> frequency scaling, undervolting when idle, P states, C states, etc.

I'm concerned about the "full load" case, where power management should
not have any noticeable impact, I think.

> Secondly, the monitoring values returned depend on the tool used to
> gather, interpret and present them to the user.

Aha!  That's more worrisome.

> You've seen yourself that the k10temp, radeon and it87 drivers report
> different temperatures, so you have to know which one the other side
> is using when comparing.

Oh, regarding which sensor is used, IIUC they use "the APU internal
sensor" which would be either k10temp or radeon's sensor, both of which
return pretty much the same temperature anyway (at least in lm-sensors).

> Also note that some tools can apply arbitrary offsets to the
> temperature values they report, to compensate for a number of things
> (like thermal sensor imperfection or distance between sensor and
> monitored item.) This is something we can in general not do under
> Linux as we do not have the information.

Hmm... so they may see incomparable values even though it comes from the
same sensor as the k10temp?

>> PS: I'm trying to argue with the company (Zotac) that my board has therm=
al
>> problems, but they suck (i.e. they dismiss GNU/Linux users), so I need
>> to be sure that the numbers they give me (which they get under Windows
>> from I don't know which tool) are comparable to the ones I see.
> This is strange, I was in contact with a Zotac engineer in late 2009 /
> early 2010 and back then they seemed to care about Linux at least to
> some extent, in particular when it came to thermal monitoring.

Either things have changed, or it simply depends on which technician you
happen to talk to.


        Stefan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
