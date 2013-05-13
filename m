From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Mon, 13 May 2013 15:36:43 +0000
Subject: Re: [lm-sensors] k10temp
Message-Id: <9203240578498506740@unknownmsgid>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130512194229.tceeg6ht8xokc884@webmail.dommel.be>
In-Reply-To: <20130512194229.tceeg6ht8xokc884@webmail.dommel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

No. It's not always a crappy sensor.

The temperature reported is not absolute temperature. It's a control
temperature normalized to 70 degrees meaning max temp.

And the accuracy is such that its most accurate near "70" degrees and
may be less accurate further away. But given the intended use of this
sensor (to monitor and keep the "temperature" below "70" degrees) that
in-accuracy away from that target is not an issue.

It should be used to verify your cooling solution is working as
intended. It is much more accurate for this purpose than the
motherboard sensors which may not be on the CPU die and are not
calibrated by the CPU manufacturer to help you. If you want to
minimize fan speeds, you can dial them down as long as the k10
"temperature" is below 70

The datasheets are very clear on this.

Phil P.

--=20
Philip Pokorny, RHCE
Chief Technical Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

On May 12, 2013, at 1:11 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Dirk,
>
> On Sun, 12 May 2013 19:42:29 +0200, dirk.p@dommel.be wrote:
>> This is not dramatic, but I think the temperature returned by k10temp ca=
n not be
>> correct. The temperature is lower than the room temperature of 14=B0C an=
d lower
>> than the more realistic values reported by it8728.
>> (...)
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> temp1:         +8.0=B0C  (high =3D +70.0=B0C)
>>                       (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)
>
> We have received countless reports of crappy temperature reports from
> k10temp. Some CPU models we even had to blacklist because they were
> hopeless. This is believed to be a hardware issue that can't be fixed.
> Just use the it8728 values if you trust them more (I would.)
>
>> (...)
>> Every time I load module i2c-piix4 I get something like
>>
>> [ 2952.162696] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 Syste=
mIO
>> conflicts with Region \SOR1 1 (20120913/utaddress-251)
>> [ 2952.162708] ACPI: If an ACPI driver is available for this device, you=
 should
>> use it instead of the native driver
>> in dmesg.
>>
>> The wrong module or something not implemented by the OEM?
>
> ACPI stealing I/O ports for its own use; unrelated with k10temp.
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
