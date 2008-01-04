From: Pelle Svensson <pelle2004@hotmail.com>
Date: Fri, 04 Jan 2008 12:15:44 +0000
Subject: Re: [lm-sensors] PWM control on Asus P4C800-E Delux dosen't
Message-Id: <BAY143-W34249C33332920046A92C5B94C0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
In-Reply-To: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Thanks guys,

I use a DC regulator insted for the chassie and it's nice and quiet now.
It's maybe not perfect but as what to do if the board dossn't have
PWM controll.

/Thanks=20

----------------------------------------
> Date: Thu, 3 Jan 2008 07:11:47 -0500
> From: mhoffman@lightlink.com
> To: khali@linux-fr.org
> CC: r.marek@assembler.cz; pelle2004@hotmail.com; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] PWM control on Asus P4C800-E Delux dosen't work=
	for chassie fan
>=20
> Hi all:
>=20
> I've been AFK for quite a while...
>=20
> * Jean Delvare  [2008-01-02 15:30:41 +0100]:
>>=20
>> Hi Rudolf,
>>=20
>> Le 29/12/2007, "Rudolf Marek"  a =E9crit:
>>>If there is no correlation found, you may try changing the base PWM
>>>frequency. I don't recall if the driver supports it (imho w83627th F ?)
>>=20
>> The W83627THF does DC fan control, not PWM, so there's no base frequency
>> to change. Not that it would have helped anyway, if the board is wired
>> for control then PWM=3D0 will stop the fan no matter the frequency.
>> Changing the frequency only changes the response curve.
>>=20
>> What Pelle could try is to connect a fan to the 3rd fan header then run
>> pwmconfig again. But as you said, if is very frequent that only the CPU
>> fan can be controlled and not the case fans, so I wouldn't hold my
>> breath.
>=20
> I have this exact board (P4C800E-Deluxe), and I can confirm that only
> the CPU fan header allows fan control.  Sorry.
>=20
> Regards,
>=20
> --=20
> Mark M. Hoffman
> mhoffman@lightlink.com
>=20

_________________________________________________________________
Spara, redigera och organisera dina foton enkelt med Photo Gallery!
http://get.live.com/photogallery/overview
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
