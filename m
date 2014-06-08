From: Fabio Baltieri <fabio.baltieri@gmail.com>
Date: Sun, 08 Jun 2014 20:54:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) Change register cache to signed
Message-Id: <CABkP77cnLvvQH-M45xJ14ny8x_z3DWPPj_zi9xtABQpvsMr4tw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402174021-25857-1-git-send-email-fabio.baltieri@gmail.com>
 <20140608201600.GA30953@roeck-us.net> <20140608203007.GA6265@roeck-us.net>
In-Reply-To: <20140608203007.GA6265@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Lothar Felten <l-felten@ti.com>, lm-sensors@lm-sensors.org

On Sun, Jun 8, 2014 at 9:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Jun 08, 2014 at 01:16:00PM -0700, Guenter Roeck wrote:
>> On Sat, Jun 07, 2014 at 09:47:01PM +0100, Fabio Baltieri wrote:
>> > All devices supported by the ina2xx driver are bidirectional and repor=
ts
>> > the measured value as a signed 16 bit, but the current driver
>> > implementation caches the number as an u16, leading to an incorrect si=
gn
>> > extension when reporting to the userspace in ina2xx_get_value().
>> >
>> > This patch fixes the problem by using a s16 instead, and has been test=
ed
>> > on an INA219.
>> >
>> > Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
>>
>> Applied.
>>
> Actually, no, this won't work. The statement above is only correct for cu=
rrent
> and shunt voltage measurements, but not for power measurements and not fo=
r bus
> voltage measurements. Changing the register to s16 won't help; conversion=
 needs
> to be done in ina2xx_get_value() for shunt voltage and current measuremen=
t only.
> Otherwise we just move the bug from current/shunt voltage measurements to
> power / bus voltage measurements.
>
> Even more interesting, the power is supposed to be the product of Bus vol=
tage
> and current, and the latter can be negative. However, the power register
> description does not suggest that the upper bit would be a sign bit. So t=
here
> is some discrepancy in the datasheet, and we'll need some real-world data=
 to
> understand if the upper power bit is signed or not.

Hi Guenter,

looks like you're right here, I wasn't paying too attention to the
power register and it actually always reads positive, even when the
current is flowing in the reverse direction, real data from the
ina219:

[55694.263502] shunt_voltage=FB46
[55694.263691] bus_voltage c2
[55694.263847] power=00fe
[55694.263954] current=FB46

I'll send a v2 to only cast the two signed register then.

Many thanks for spotting this!

Fabio

--=20
Fabio Baltieri

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
