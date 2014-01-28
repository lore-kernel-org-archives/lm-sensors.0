From: John <da_audiophile@yahoo.com>
Date: Tue, 28 Jan 2014 20:17:41 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <1390940261.15519.YahooMailNeo@web140006.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Mon, 27 Jan 2014 23:46:31 -0800, Guenter Roeck wrote:

>>  On 01/27/2014 11:22 PM, Jean Delvare wrote:
>>  > It's not only noise, the problem is real. Thanks for reporting it=20
> early
>>  > so we have a chance to fix it before it hits too many users.

**Please note that I have unsubscribed from the ML so keep cc'ing me like y=
ou have if you want me to get the communications :p

Glad my neurotic tendencies have helped :)

> John, can you please test:
> http://jdelvare.nerim.net/devel/lm-sensors/fancontrol
> and confirm that it works fine with your old configuration file under
> kernel 3.13?


Glad to give back by testing. =A0Yes, your new script uses my old config fi=
le under 3.13 just fine:


# unlink /etc/fancontrol
# ln -s /etc/fancontrol-3.12.9 /etc/fancontrol
# ./fancontrol-test

Loading configuration from /etc/fancontrol ...

Common settings:
=A0 INTERVAL=3D10

Settings for hwmon1/device/pwm5:
=A0 Depends on hwmon0/device/temp4_input
=A0 Controls hwmon1/device/fan5_input
=A0 MINTEMP=3D20
=A0 MAXTEMP=3D60
=A0 MINSTART=3D80
=A0 MINSTOP=3D75
=A0 MINPWM=3D75
=A0 MAXPWM=3D255

Settings for hwmon1/device/pwm4:
=A0 Depends on hwmon0/device/temp4_input
=A0 Controls hwmon1/device/fan4_input
=A0 MINTEMP=3D20
=A0 MAXTEMP=3D60
=A0 MINSTART=3D80
=A0 MINSTOP=3D65
=A0 MINPWM=3D65
=A0 MAXPWM=3D255

Settings for hwmon1/device/pwm3:
=A0 Depends on hwmon0/device/temp4_input
=A0 Controls hwmon1/device/fan3_input
=A0 MINTEMP=3D20
=A0 MAXTEMP=3D60
=A0 MINSTART=3D80
=A0 MINSTOP=3D60
=A0 MINPWM=3D60
=A0 MAXPWM=3D255

Settings for hwmon1/device/pwm1:
=A0 Depends on hwmon0/device/temp4_input
=A0 Controls hwmon1/device/fan1_input
=A0 MINTEMP=3D20
=A0 MAXTEMP=3D60
=A0 MINSTART=3D80
=A0 MINSTOP=3D60
=A0 MINPWM=3D60
=A0 MAXPWM=3D255

Adjusing hwmon1/device/pwm5 -> hwmon1/pwm5
Adjusing hwmon1/device/pwm4 -> hwmon1/pwm4
Adjusing hwmon1/device/pwm3 -> hwmon1/pwm3
Adjusing hwmon1/device/pwm1 -> hwmon1/pwm1
Adjusing hwmon1/device/fan5_input -> hwmon1/fan5_input
Adjusing hwmon1/device/fan4_input -> hwmon1/fan4_input
Adjusing hwmon1/device/fan3_input -> hwmon1/fan3_input
Adjusing hwmon1/device/fan1_input -> hwmon1/fan1_input
Enabling PWM on fans...
Starting automatic fan control...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
