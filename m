From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Tue, 08 Jan 2013 00:45:58 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <201301080045.r080jvEc016052@mx1.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of Leslie Rhorer
> Sent: Monday, January 07, 2013 5:54 PM
> To: 'Jean Delvare'
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
>=20
>=20
> > > but temp1 on k10temp obviously is not, so it
> > > would seem it requires some computation, but using what values?
> >
> > AMD CPU sensors are notoriously off, and even more so in low
> > temperature ranges. Do not see the above as 10.2=B0C but just as "there=
's
> > a lot of thermal margin up to the high limit" i.e. your CPU cooling is
> > very efficient.
>=20
> 	Hmm.  Ok, that may explain the behavior of the PCI sensor I reported
> in the subsequent message.  Perhaps the temperature needs to be higher
> before the sensor is stable?  The actual temperature is about 45=B0C
> according
> to an IR thermometer.
>=20
> > > What about the temp1 and temp2 sensors on it87?
> >
> > You can try putting some load on the CPU to see if any of these
> > correspond to the CPU temperature (it would rise faster.)
>=20
> 	Well, I tried that, but both temp1 readings soar.  OTOH, I did not
> notice the it87 temp1 reading going up when I shut off the Coolant fan.
> With all 8 cores running greater than 25% and two of them running more
> than
> 50%, the it87 temp1 is running around 51=B0C and the k10temp temp1 is abo=
ut
> 41=B0C.  I'll shut down the server in a few minutes and see what the BIOS
> reports.

	When I rebooted, the BIOS only reports two temperatures, one it
labels "Motherboard" and the other it labels "CPU".  Unlike the reports from
`sensors`, the CPU temperature looks right (about 37=B0C) and the CPU temp =
is
higher than the MB temp.  Again, there is a lack of consistency, so it is
difficult to tell which is which, or how much I might rely on either one as
a metric to trigger a shut down of the machine.

> > Do you see all fan speeds in the BIOS? If you do, and go from the BIOS
>=20
> 	As I recall, yes.  A couple of them were off the chart, however.  I
> presumed it indicated a bad divisor.

	When I rebooted, only 1 of the fans was reporting an absurd
rotational speed.  The Coolant Fan was jumping up and down all over the
place in the advanced screen, and reporting about 57,000 rpn on the main
screen.  I swapped the Coolant Fan and the Pump, putting the Coolant fan on
the CPU_FAN connector, and the faulty reporting stopped.  The "musical
sensors" under Linux does not seem to have stopped, however, although I am
not entirely certain of that.  Oddly enough, however, I am certain of the
fact in the current state removing the Rear Fan #1 from the CHA_FAN1
connector drops fan2, but connecting the pump to it does not return the
monitor point.  Putting the Rear Fan #1 back does restore it.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
