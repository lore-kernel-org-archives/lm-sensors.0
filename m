From: Virgil Gheorghiu <virgilg@cs.uchicago.edu>
Date: Thu, 09 Sep 2010 12:42:45 +0000
Subject: Re: [lm-sensors] ECS H55H-I Support (Suspected IT8721F Chipset)
Message-Id: <B1494B8A-BDBF-429C-B93C-368E0E88A296@cs.uchicago.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
In-Reply-To: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Good morning, Jae,

> Not really sure how to configure the sensors.conf for my mobo but all I'm=
 really
> interested in is temperature so I think I am there.
Per your output, I'd do, for example:

root@box:~# mv /etc/sensors.conf{,.orig}
root@box:~# cat <<-EOF > /etc/sensors.conf
chip "it8758-*"
	ignore temp2	# since sensor =3D disabled
	label temp1 "CPU0 Temp" # check BIOS name and value
	label temp3 "System Temp" # check BIOS name and value

	set temp1_min 15
	set temp1_max 70 # min(CPU junction specs, your idea of hot :-)
	set temp3_min 20
	set temp3_max 80 # ibid.
EOF
root@box:~# sensors -s # to set the min/max values

> temp1:       +49.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
> temp2:      -128.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D disabled
> temp3:       +37.0=B0C  (low  =3D +127.0=B0C, high =3D +80.0=B0C)  sensor=
 =3D thermal diode
>=20
> 49 and 37 seem pretty low but if they're right I'd be really happy.
I recommend you check those values (and names) against what the BIOS report=
s.
There should be an entry in the BIOS labeled PC Health or similar.
On the same page you should also see voltages for CPU, RAM, & co.

Note I don't trust at all the voltage equations I wrote, since I didn't go =
read the datasheet for the chip; it looks like it's impossible to find.

Thank you,
Virgil
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
