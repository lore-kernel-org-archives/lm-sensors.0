From: "Jean Delvare" <khali@linux-fr.org>
Date: Wed, 02 Jan 2008 14:30:41 +0000
Subject: Re: [lm-sensors] PWM control on Asus P4C800-E Delux dosen't work
Message-Id: <lbe9t7Xd.1199284241.2788760.khali@gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
In-Reply-To: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Rudolf,

Le 29/12/2007, "Rudolf Marek" <r.marek@assembler.cz> a =E9crit:
>If there is no correlation found, you may try changing the base PWM
>frequency. I don't recall if the driver supports it (imho w83627th F ?)

The W83627THF does DC fan control, not PWM, so there's no base frequency
to change. Not that it would have helped anyway, if the board is wired
for control then PWM=3D0 will stop the fan no matter the frequency.
Changing the frequency only changes the response curve.

What Pelle could try is to connect a fan to the 3rd fan header then run
pwmconfig again. But as you said, if is very frequent that only the CPU
fan can be controlled and not the case fans, so I wouldn't hold my
breath.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
