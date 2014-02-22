From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 22 Feb 2014 09:13:18 +0000
Subject: Re: [lm-sensors] Configuration for Gigabyte Z77-D3H
Message-Id: <20140222101318.257fef2b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52D45149.20804@tuxedo.ath.cx>
In-Reply-To: <52D45149.20804@tuxedo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Mathias,

On Sat, 22 Feb 2014 02:29:48 +0100, Mathias Gerber wrote:
> On 21.02.2014 11:21, Jean Delvare wrote:
> > What makes you think this is Vtt and not Vcore? Almost all boards
> > have Vcore on in0.
> The actual reading is 1.07V, and if I change the CPU Vtt Voltage in
> the BIOS, the value also changes according.
> The same feature was in discussion on the AIDA forums [1] for almost
> the same mainboard.

OK.

> >> compute in1 1.649*@,@/1.649 # multipliers provided by Martin
> >> Malik author of hwinfo
> > Couldn't you figure it out from the BIOS?
> As I installed the mainboard I found the factor in the wiki [2] from a
> board with the same hwmon chip. With this my BIOS and lm-sensors
> readings matched (BIOS: 3.304, lm-sensors -u: 3.305) So I did no
> further investigations.
>
> But now since you asked my I tried to accept the challenge ;-) Sadly
> I'm very confused now.. I tried to find as many 3.3V BIOS readings
> from the same or similar boards and found the following:

Beware of "similar boards". We've seen boards with almost the same name
that had slightly different monitoring setups. Sometimes even different
hardware revisions of the same board can differ in the details. I seem
to recall I've even seen once a BIOS update which changed one scaling
factor as apparently is was wrong originally.

> U [V]	U_Delta [V]	Ref URL
> 3.284=09
> 3.304	0.02
> 3.324	0.02
> 3.344	0.02		[3]
> 3.363	0.019		[4]
> 3.383	0.02
> 3.423	0.04
>=20
> Very confusing measurements, especially the step after 3.363V upwards!
> With all these measurements I assumed a 0.02V step in the reading and
> calculated the factor (20 / 12) which leads to an too high reading
> (3.340 instead of 3.304V)
> With an assumed step of 0.019V the reading is to low (3.173V instead
> of 3.304V)
> Calculated reverse the BIOS reading and the unscaled lm-sensors output
> (3.304*12/2.004) I get an (19.78 / 12) factor which leads me to an
> almost corresponding reading to the BIOS value in sensors (3.303V)

You should keep a lot of decimals when searching for the scaling
factor. 3.304*12/2.004 is really 19.784431, not 19.78. And 19.78443 /
12 is closer to 1.649 (Martin Malik's value) than 1.648 (which leads to
3.303 V, not matching the BIOS.)

> But the scale seems to have an strange stepping anyway.. Have you seen
> this before?

Yes, we've seen this before, in particular on Gigabyte boards. See the
+12V scaling factor here for example:
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/GA-945GCM-S2L

Martin Malik's 1.649 actually looks good to me, as it maps register
values to exactly all the BIOS values you listed above. So let's stick
to it.

> >> set in7_min 3.00 * 0.95 set in7_max 3.00 * 1.05
> > 3VSB is normally 3.3V so these limits look wrong.
> You're right, my fault.
>=20
>   set in7_min 3.3 * 0.95
>   set in7_max 3.3 * 1.05
>=20
> Actual reading here in7_input: 3.384

OK, fixed in the wiki.

> > Does the it87 driver say anything about voltage mapping when you
> > load it? If in7 us 3VSB it should already be labeled properly.
> Yes it is.

OK, fixed. Are there other pre-labelled voltage inputs?

> >> label temp1 "PCH temp??" # shows always 33=B0C set temp1_min 10 set
> >> temp1_max 60
> I monitored these temperatures after a cold boot and this value seems
> to match the "System temperature" in the BIOS health status.
>=20
>     label temp1 "System temp"
>     set temp1_min 10
>     set temp1_max 60

OK, wiki updated.

> >> ignore temp2 label temp2 "MB temp??" # shows always 25=B0C set
> >> temp2_min 0 set temp2_max 60
> Checked this temp again. Found that on the GA-Z77X-D3H this is PCH
> temperature. On this board it has also an BIOS reading for it, I dont.
>=20
> > Current version of the configuration file is here: Thanks for your
> > contribution.
> Thank you!

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
