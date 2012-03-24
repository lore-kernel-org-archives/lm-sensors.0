From: Guenter Roeck <guenter@roeck-us.net>
Date: Sat, 24 Mar 2012 16:23:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bjoern,

At 01:11 AM 3/24/2012, Bj=F6rn Gerhart wrote:
[ ... ]

>     label temp3 "CPU T."
>     compute temp3 100+@,-1*(100-@)

Is it possible that this is due to a bad sensor type configuration ?

Thermal diodes have a "current mode" and a=20
"voltage mode", and if misconfigured (or=20
miswired) the reported temperature difference is=20
just about in that range. Difference in wiring,=20
if I understand it correctly, is that the + pin=20
is pulled high with a resistor in voltage mode,=20
which is not the case in current mode.

Problem with the wrong reading is that it affects=20
the sensor's dynamic range. You don't have much=20
dynamic range left if the reading is off by 100 degrees.

Thanks,
Guenter=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
