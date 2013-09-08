From: "Tomas Larsson" <tomas@tlec.se>
Date: Sun, 08 Sep 2013 21:28:11 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEd5si8itE1Es0sRfKL6z1sBAAAAAA==@tlec.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



With best regards
Tomas Larsson
TL Engineering & Consultants (TLEC)
Engelbrektsgatan 121
SE 50639 Bor=E5s
Sweden
+46 (0)739-932673
tomas@tlec.se
www.tlec.se


> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Sunday, September 08, 2013 11:20 PM
> To: Tomas Larsson
> Cc: 'Jean Delvare'; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>=20
> On 09/08/2013 01:01 PM, Tomas Larsson wrote:
> >> -----Original Message-----
> >> From: Jean Delvare [mailto:khali@linux-fr.org]
> >> Sent: Sunday, September 08, 2013 9:10 PM
> >> To: Guenter Roeck
> >> Cc: Tomas Larsson; lm-sensors@lm-sensors.org
> >> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
> >>
> >> On Sun, 08 Sep 2013 11:58:39 -0700, Guenter Roeck wrote:
> >>> Different driver. Centos 6.4 uses the coretemp driver which gets the
> >>> temperature from the CPU directly. Unfortunately, Centos 6.4 is
> >>> quite old when it comes to kernel version, and so is its coretemp
driver.
> >>> The displayed temperatures in your version are all wrong; the
> >>> maximum
> >> temperature for Atom 330 is 125 degrees C, not 90 degrees C.
> >>> You'll have to add 35 degrees C to the displayed temperature.
> >>>
> >>> You could either update the coretemp driver to a later version to
> >>> fix this, or add the offset to /etc/sensors3.conf.
> >>>
> >>> Note that CPU temperatures are notoriously unreliable.
> >>
> >> "Inaccurate in the low temperature range" is a better way to describe
> >> the situation IMHO. The coretemp values are reliably telling the user
> >> when the temperature gets too close to the high limit.
> >>
> >> --
> >> Jean Delvare
> >
> > Well, I'm aware of that, what I want to know is when the fan fails,
> > these 40mm fans are not that reliable, unfortunately.
>=20
> Not sure if you can use the cpu temperature to predict if the fans are
working
> or not. The CPU can get pretty hot under load, even with the fans working.
>=20
> Your initial e-mail showed the fan speeds as 0. Are they broken or turned
off
> or not connected to the fan speed sensors ?
>=20
> Guenter
Haven't got a clue why it says that they are 0, they definitely work now
(changed the fans today), They are 3-pins and connected to the correct
header.

On the Centos 6 mashine, I obviously don't get any fan-speed though.

Tomas Larsson


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
