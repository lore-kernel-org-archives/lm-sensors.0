From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Feb 2008 21:33:46 +0000
Subject: Re: [lm-sensors] CPU temperature
Message-Id: <20080205223346.04549341@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1896.10.16.10.158.1201357238.squirrel@mail.serc.iisc.ernet.in>
In-Reply-To: <1896.10.16.10.158.1201357238.squirrel@mail.serc.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Kiran,

On Sat, 26 Jan 2008 19:50:38 +0530 (IST), kiran@serc.iisc.ernet.in wrote:
>   We have IBM Intellistation, I am using lm_sensors-2.10.1-1.fc6. It is
> working fine. But when i run sensors it shows three temperatures as
> temp1 temp2 and temp3. Kindly indicate in this three which is CPU
> temperature.
>=20
> temp1:       +58=B0C  (high =3D   +71=B0C, hyst =3D   +66=B0C)
> temp2:    +127.0=B0C  (high =3D  -128=B0C, hyst =3D  +126=B0C)   ALARM
> temp3:     +35.5=B0C  (high =3D   +41=B0C, hyst =3D   +39=B0C)

Which temperature channel corresponds to what is board-dependent, so we
don't know. Here are hints to help you figure out though:

* 127 degrees C doesn't look real, it's way too high and it's the max
  value the chip can report. So most probably temp2 isn't connected
  to an actual thermal sensor. You can ignore it by adding an
  "ignore temp2" line in the right section of /etc/sensors.conf.

* temp1 is much higher than temp3, this suggests that temp1 is
  the CPU temperature while temp3 would be the board temperature.
  You can confirm this by running a CPU-intensive task (e.g. "md5sum
  /dev/zero"). Whichever temperature value rises faster has to be
  the CPU temperature.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
