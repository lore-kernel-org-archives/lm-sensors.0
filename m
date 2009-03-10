From: "Fred ." <eldmannen@gmail.com>
Date: Tue, 10 Mar 2009 22:52:53 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <f188924b0903101552l41ce0f62ud6de878de8e1e6d1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I don't know anything about anything.
But sounds good to me. Looks solid, I think.

Add support in Fintek f71882fg too.

On Tue, Mar 10, 2009 at 5:03 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi all,
>
> A number of users have asked us to support the chassis intrusion
> detection feature which some hardware monitoring chip have. I've
> created a ticket for this:
> http://www.lm-sensors.org/ticket/2370
>
> I have made a first proposal 3 weeks ago, and got a number of
> interesting comments about it. Here comes a second version hopefully
> addressing all the concerns that had been raised. Changes include:
> * Handle multiple intrusion detection switches.
> * Let the user control whether chassis intrusion should result in
> =A0system beeping or not. At least the Winbond W83793G supports this, and
> =A0probably other chips as well.
>
>
> sysfs interface
> =3D=3D=3D=3D=3D=3D=3D>
> intrusion[0-*]_alarm
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Chassis intrusion detection
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00: OK
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01: intrusion detected
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RW
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Contrary to regular alarm flags which clea=
r themselves
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0automatically when read, this one sticks u=
ntil cleared by
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the user. This is done by writing 0 to the=
 file. Writing
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0other values is unsupported.
>
> intrusion[0-*]_beep
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Chassis intrusion beep
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00: disable
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01: enable
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RW
>
> drivers
> =3D=3D=3D>
> Drivers adm9240, w83792d and w83793 implement this feature in
> non-standard ways. They should be converted to the new, standard
> interface.
>
> libsensors
> =3D=3D=3D=3D=3D
>
> SENSORS_FEATURE_INTRUSION =3D 0x19
> SENSORS_SUBFEATURE_INTRUSION_ALARM =3D (SENSORS_FEATURE_INTRUSION << 8) |=
 0x80
> SENSORS_SUBFEATURE_INTRUSION_BEEP =3D SENSORS_SUBFEATURE_INTRUSION_ALARM =
+ 1
>
> sensors
> =3D=3D=3D>
> Reading the value of the chassis intrusion alarm and beep subfeatures
> is done like for any other subfeature. Likewise for writing to the beep
> subfeature.
>
> Writing to the alarm subfeature, OTOH, can't be handled the same as
> writing limits, because we certainly don't want to clear the flag
> automatically at lm_sensors start or restart time. So we could add a
> dedicated flag to clear the intrusion detection flag (e.g. "sensors
> --clear-intrusion").
>
>
> If anyone has objections or comments, please speak up.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
