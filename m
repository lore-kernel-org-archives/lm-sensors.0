From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 26 May 2010 21:10:01 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (ltc4245) expose all GPIO pins
Message-Id: <AANLkTilGy4C8iYab6tk9qQDjL7KIafpA5r92uaTwz98m@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, May 26, 2010 at 2:56 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> On Wed, May 26, 2010 at 02:37:28PM -0600, Grant Likely wrote:
>> On Wed, May 26, 2010 at 1:39 PM, Ira W. Snyder <iws@ovro.caltech.edu> wr=
ote:
>> > On Wed, May 26, 2010 at 08:42:22PM +0200, Jean Delvare wrote:
>> >> On Wed, 26 May 2010 10:22:44 -0700, Ira W. Snyder wrote:
>> >> > On Wed, May 26, 2010 at 06:36:59PM +0200, Jean Delvare wrote:
>> >> > > Sorry for not being clear. I wasn't objecting to the stub's exist=
ence,
>> >> > > but to the fact that it was doing something. I expected it to do
>> >> > > nothing at all, and ltc4245_show_voltage() would be used for in9.
>> >> >
>> >> > Oh, ok. The ltc4245_show_voltage() function reads the voltage regis=
ter
>> >> > values directly from data->vregs[]. When the extra GPIO inputs are
>> >> > enabled, I have two choices:
>> >> >
>> >> > 1) store them in the new data->gpios[] array
>> >> > 2) store them in data->vregs[]
>> >> >
>> >> > For #1, ltc4245_show_voltage() doesn't work anymore, since it reads
>> >> > voltage register values from data->vregs[].
>> >> >
>> >> > For #2, I would have to re-expand data->vregs[] to include all of t=
he
>> >> > GPIO inputs, like it was before. Also, I would need to make
>> >> > ltc4245_get_voltage() handle the -EAGAIN error code.
>> >> >
>> >> > I think the code is easier to understand if all the GPIOs are treat=
ed in
>> >> > the same way, and not completely special for GPIOADC1 vs GPIOADC[23=
].
>> >> > That's why I chose #1.
>> >> >
>> >> > If I do a hybrid approach (store GPIOADC1 in data->vregs[] and
>> >> > GPIOADC[23] in data->gpios[]), then I have to make ltc4245_get_volt=
age()
>> >> > robust against errors too. Is this what you're suggesting?
>> >>
>> >> No. But let's wait and see if you move to OF platform data, the whole
>> >> question will be moot. If you keep the config option approach, I'll
>> >> propose an iterative patch and we can discuss it then.
>> >>
>> >> > (...)
>> >> > Any thoughts about the kernel config option vs. platform data, and =
how
>> >> > it relates to the OF bindings?
>> >>
>> >> I would prefer platform-data-based. But I fear I don't know anything
>> >> about OF bindings. Better ask the embedded folks (e.g. Grant Likely),
>> >> they will know.
>> >>
>> >
>> > Grant, you're listed in MAINTAINERS as the OF bindings maintainer. Is =
it
>> > currently possible for the i2c OF binding to pass platform_data to hwm=
on
>> > drivers that are probed via the device tree? If so, can you point me to
>> > an example. If not, can you suggest what I should do?
>> >
>> > Here is a short example from my device tree (a lightly modified 834x_m=
ds
>> > device tree):
>> >
>> > i2c@3100 {
>> > =E1 =E1 =E1 =E1#address-cells =3D <1>;
>> > =E1 =E1 =E1 =E1#size-cells =3D <0>;
>> > =E1 =E1 =E1 =E1cell-index =3D <1>;
>> > =E1 =E1 =E1 =E1compatible =3D "fsl-i2c";
>> > =E1 =E1 =E1 =E1reg =3D <0x3100 0x100>;
>> > =E1 =E1 =E1 =E1interrupts =3D <15 0x8>;
>> > =E1 =E1 =E1 =E1interrupt-parent =3D <&ipic>;
>> > =E1 =E1 =E1 =E1clock-frequency =3D <400000>;
>> >
>> > =E1 =E1 =E1 =E1ltc4245@XX {
>> > =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1compatible =3D "LLTC,ltc4245";
>> > =E1 =E1 =E1 =E1 =E1 =E1 =E1 =E1reg =3D <0>; =E1 =E1 =E1// from bootloa=
der
>> > =E1 =E1 =E1 =E1};
>> > };
>> >
>> > I'd like to be able to send platform data to the drivers/hwmon/ltc4245=
.c
>> > driver. On my platform, this is probed automatically using the device
>> > tree snippet above.
>>
>> What is in the platform data?
>
> A bool/int should be sufficient.
>
>> As of the .35 merge window, the device
>> node pointer lives in struct device, so it is available to all Linux
>> device drivers if CONFIG_OF is set. =A0If it is simply data that needs
>> to be passed, then the driver itself can extract it from the tree in
>> the absence of pdata. =A0If you need to pass function pointers or the
>> like, then probably the best thing to do is to register a bus notifier
>> in the platform code before registering devices. =A0That way the
>> platform code can intercept the device and register pdata before the
>> device is bound to a driver.
>
> Ok, so I should wrap the OF detection code in CONFIG_OF in my driver,
> right? I just quickly browsed through the code, and it seems like it
> should be straightforward to use pdata and then fall back on OF data.

Correct.  The goal is to allow the driver-specific OF adapter code to
live with the driver, while still having as little as possible impact
on driver design as a whole.

g.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
