From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Oct 2010 15:15:57 +0000
Subject: Re: [lm-sensors] ECS H55H-I Support (Suspected IT8721F Chipset)
Message-Id: <20101011171557.5728a277@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
In-Reply-To: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 9 Sep 2010 07:42:45 -0500, Virgil Gheorghiu wrote:
> Good morning, Jae,
>=20
> > Not really sure how to configure the sensors.conf for my mobo but all I=
'm really
> > interested in is temperature so I think I am there.
> Per your output, I'd do, for example:
>=20
> root@box:~# mv /etc/sensors.conf{,.orig}
> root@box:~# cat <<-EOF > /etc/sensors.conf
> chip "it8758-*"
> 	ignore temp2	# since sensor =3D disabled
> 	label temp1 "CPU0 Temp" # check BIOS name and value
> 	label temp3 "System Temp" # check BIOS name and value

This is rather unlikely IMHO. The fact that only temp3 has type thermal dio=
de and only temp3 has its high limit set to a sensible
value, my own guess is that temp3 is the CPU temperature. Which would
leave temp1 for the system temperature.

Obviously CPU temperature lower than system temperature is suspicious,
so there may be some offset to apply. In any case it would be
interesting to see what the BIOS reports.

>=20
> 	set temp1_min 15
> 	set temp1_max 70 # min(CPU junction specs, your idea of hot :-)
> 	set temp3_min 20
> 	set temp3_max 80 # ibid.
> EOF
> root@box:~# sensors -s # to set the min/max values
>=20
> > temp1:       +49.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermistor
> > temp2:      -128.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sens=
or =3D disabled
> > temp3:       +37.0=B0C  (low  =3D +127.0=B0C, high =3D +80.0=B0C)  sens=
or =3D thermal diode
> >=20
> > 49 and 37 seem pretty low but if they're right I'd be really happy.
> I recommend you check those values (and names) against what the BIOS repo=
rts.
> There should be an entry in the BIOS labeled PC Health or similar.
> On the same page you should also see voltages for CPU, RAM, & co.
>=20
> Note I don't trust at all the voltage equations I wrote, since I didn't g=
o read
> the datasheet for the chip; it looks like it's impossible to find.

We do have a datasheet. It's not public as far as I know, we got it
from ITE. I can confirm that your voltages are wrong, as the
IT8721F/IT8758E has a 12mV ADC instead of 16mV as all other supported
chips have. So all your raw voltage readings are 33% higher than they
should be.

Virgil, I'm adding you to the list of people interested in
IT8721F/IT8758E support.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
