From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Wed, 22 Jan 2014 17:59:00 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <52E006E4.3020008@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Guenter

On 22.01.2014 18:27, Guenter Roeck wrote:
> Interesting. Obviously that doesn't help ;-). What is returned
> back if you read pwm2 after setting it to 0 ?
0 (zero). Maybe some sort of protection?

> You might try setting pwm2_auto_point1_pwm to your preferred
> minimum (assuming pwm2_enable is set to 5). If that doesn't help,
> please send me the output of all pwm2 attributes ('grep .
> /sys/class/hwmon/hwmon1/device/pwm2*').
Thanks for this hint. I didn't knew about this possibility.

For my needs I set these values:
pwm2_auto_point1_pwm	7
pwm2_auto_point1_temp	30000
pwm2_auto_point2_pwm	178 (default)
pwm2_auto_point2_temp	55000
pwm2_auto_point3_pwm	255 (default)
pwm2_auto_point3_temp	75000 (default)

With these settings the CPU fan (fan2) runs quiet as wished :-)

> Side note: If you run 3.13 or later kernels, the attributes will
> move to /sys/class/hwmon/hwmonX/.
$ uname -a
Linux myhost 3.2.0-4-amd64 #1 SMP Debian 3.2.51-1 x86_64 GNU/Linux

$ sensors -v
sensors version 3.3.2 with libsensors version 3.3.2

thanks alot!
- --=20
kind regards
 Mathias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLgBuQACgkQnfTEjDUZ2fMmiwCg14GK/saUyIDb9Yx1GPyTSZMr
z1EAn2Pn0FFo3dxymI5mUggjq6Qn7gHX
=A5eN
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
