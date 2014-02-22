From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Sat, 22 Feb 2014 01:29:48 +0000
Subject: Re: [lm-sensors] Configuration for Gigabyte Z77-D3H
Message-Id: <5307FD8C.7030102@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <52D45149.20804@tuxedo.ath.cx>
In-Reply-To: <52D45149.20804@tuxedo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean

On 21.02.2014 11:21, Jean Delvare wrote:
> I've dropped all the prefixes in voltage labels.
k

> What makes you think this is Vtt and not Vcore? Almost all boards
> have Vcore on in0.
The actual reading is 1.07V, and if I change the CPU Vtt Voltage in
the BIOS, the value also changes according.
The same feature was in discussion on the AIDA forums [1] for almost
the same mainboard.

>> compute in1 1.649*@,@/1.649 # multipliers provided by Martin
>> Malik author of hwinfo
> Couldn't you figure it out from the BIOS?
As I installed the mainboard I found the factor in the wiki [2] from a
board with the same hwmon chip. With this my BIOS and lm-sensors
readings matched (BIOS: 3.304, lm-sensors -u: 3.305) So I did no
further investigations.

But now since you asked my I tried to accept the challenge ;-) Sadly
I'm very confused now.. I tried to find as many 3.3V BIOS readings
from the same or similar boards and found the following:
U [V]	U_Delta [V]	Ref URL
3.284=09
3.304	0.02
3.324	0.02
3.344	0.02		[3]
3.363	0.019		[4]
3.383	0.02
3.423	0.04

Very confusing measurements, especially the step after 3.363V upwards!
With all these measurements I assumed a 0.02V step in the reading and
calculated the factor (20 / 12) which leads to an too high reading
(3.340 instead of 3.304V)
With an assumed step of 0.019V the reading is to low (3.173V instead
of 3.304V)
Calculated reverse the BIOS reading and the unscaled lm-sensors output
(3.304*12/2.004) I get an (19.78 / 12) factor which leads me to an
almost corresponding reading to the BIOS value in sensors (3.303V)
But the scale seems to have an strange stepping anyway.. Have you seen
this before?

>> set in7_min 3.00 * 0.95 set in7_max 3.00 * 1.05
> 3VSB is normally 3.3V so these limits look wrong.
You're right, my fault.

  set in7_min 3.3 * 0.95
  set in7_max 3.3 * 1.05

Actual reading here in7_input: 3.384

> Does the it87 driver say anything about voltage mapping when you
> load it? If in7 us 3VSB it should already be labeled properly.
Yes it is.

>> label temp1 "PCH temp??" # shows always 33=B0C set temp1_min 10 set
>> temp1_max 60
I monitored these temperatures after a cold boot and this value seems
to match the "System temperature" in the BIOS health status.

    label temp1 "System temp"
    set temp1_min 10
    set temp1_max 60

>> ignore temp2 label temp2 "MB temp??" # shows always 25=B0C set
>> temp2_min 0 set temp2_max 60
Checked this temp again. Found that on the GA-Z77X-D3H this is PCH
temperature. On this board it has also an BIOS reading for it, I dont.

> Current version of the configuration file is here: Thanks for your
> contribution.
Thank you!

[1]
> http://forums.aida64.com/topic/741-gigabyte-z77x-d3h-sensor-readings/#ent=
ry4377

[2]
>=20
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/H67MA-UD2H

[3]
> http://www.hardwareluxx.de/community/f219/gigabyte-ga-z77x-d3h-ud3h-udh3-=
wb-wifi-ud5h-ud5h-wb-wifi-z77-882581-36.html#post18864263

[4]
>
>=20
http://www.overclockers.ru/lab/47769_3/Obzor_i_testirovanie_materinskoj_pla=
ty_Gigabyte_GA-Z77-D3H.html
- --=20
kind regards
 Mathias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMH/YYACgkQnfTEjDUZ2fN8+QCgsEvT1SO7s53SlslcxQylOcdY
O3kAmwXGtX4elWXvaeDni0LyUcUm7hJ6
=3DXiZT
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
