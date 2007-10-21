From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 21 Oct 2007 13:37:05 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <471B5601.7060904@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

JAMES SCOTT wrote:
>=20
> ----- Original Message ----
> From: Jean Delvare <khali@linux-fr.org>
> To: James Scott Jr <skoona@verizon.net>
> Cc: Hans de Goede <j.w.r.degoede@hhs.nl>; lm-sensors@lm-sensors.org
> Sent: Saturday, October 20, 2007 4:49:01 PM
> Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sens=
ors'
>=20
> On Fri, 19 Oct 2007 22:53:09 -0400, James Scott Jr wrote:
>> Thank you, sensor's output is now correct - coretemp's is wacked.  I
>> will look into whats happening with coretemp, later.
>>
>> [jscott@vserv ~]$ sensors
>> (...)
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +54=B0C  (high =3D  +100=B0C)                  =20
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1:      +51=B0C  (high =3D  +100=B0C)                  =20
>>
>> coretemp-isa-0002
>> Adapter: ISA adapter
>> Core 2:      +52=B0C  (high =3D  +100=B0C)                  =20
>>
>> coretemp-isa-0003
>> Adapter: ISA adapter
>> Core 3:      +50=B0C  (high =3D  +100=B0C)                  =20
>>
>=20
> The coretemp values actually look alright to me.
>=20
> Jean; The abituguru3... sensors output showed 'CPU 40c' and coretemp... d=
etails the same CPU around '50c'.  So, I have output, it is formatted corre=
ctly.  However, I believe the reported value is wrong.  10c is a huge diffe=
rence in values - which is correct?  All Cores are running Folding@Home at =
100%, so this is a load temp and would not be available if I rebooted to bi=
os to verify.
>=20
> I did not find the coretemp-isa-* in the sensors.conf file.  Do you know =
where the computes for this module are setup?

James,

For some reason later versions of the uguru (and earlier versions too after=
 a=20
BIOS update) seem to report much too low CPU temp values. I guess they are =

reporting the actual sensor value and adding some offset to compensate for =
the=20
distance between the sensor on the motherboard and the actual CPU.

So I think the core temp readings are correct, esp. for a loaded system.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
