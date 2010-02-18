From: "Artem S. Tashkinov" <birdie@permonline.ru>
Date: Thu, 18 Feb 2010 11:25:48 +0000
Subject: Re: [lm-sensors] A question regarding ASRock H55DE3 motherboard
Message-Id: <4B7D23BC.2070305@permonline.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030109070806010504060406"
List-Id: <lm-sensors.vger.kernel.org>
References: <4B7A403E.7000103@permonline.ru>
In-Reply-To: <4B7A403E.7000103@permonline.ru>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109070806010504060406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On 02/18/2010 02:15 AM, Jean Delvare wrote:
> On Thu, 18 Feb 2010 01:08:04 +0500, Artem S. Tashkinov wrote:
>> On 02/18/2010 12:19 AM, Jean Delvare wrote:
>>   >  This driver should be available. If it's not there, this suggests=
 that
>>   >  you did not set CONFIG_SENSORS_ADT7473=3Dm when building your ker=
nel. You
>>   >  should have...
>>
>> I will try to build this driver and report if it shows anything.
>
> Note: last time I checked (long ago), the binary nvidia driver which
> you appear to be using, did not let hwmon driver probe its I2C buses
> for devices. So you might have to instantiate the chip yourself with:
>
> # echo adt7473 0x2e>  /sys/class/i2c-adapter/i2c-<N>/device/new_device
>
> where<N>  is the bus number of the i2c bus in question.

echo adt7473 0x2e > /sys/class/i2c-adapter/i2c-3/new_device produced the=20
desired results:

adt7473-i2c-3-2e
Adapter: NVIDIA i2c adapter
in1:         +3.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)
+3.3V:       +3.33 V  (min =3D  +0.00 V, max =3D  +4.39 V)
fan1:        889 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D  164 RPM)  ALARM
temp1:       +39.2=B0C  (low  =3D +65.0=B0C, high =3D +85.0=B0C)  ALARM
                       (crit =3D +100.0=B0C, hyst =3D +98.0=B0C)
Board Temp:  +33.8=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
                       (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)
temp3:       +39.2=B0C  (low  =3D +80.0=B0C, high =3D +105.0=B0C)  ALARM
                       (crit =3D +136.0=B0C, hyst =3D +132.0=B0C)

The output needs to be configured (via /etc/sensors.d/chipname.conf),=20
but that's not a problem.

>
>> (...)
>> It looks like it's my own blunder: I have confused w83_2_627 to w83627
>> :) and taking into consideration ASRock's documentation my chip is
>> indeed made by Nuvoton and it's currently unsupported - I'm eagerly
>> awaiting patches to be merged.
>
> Hmm, does the W832627 actually exist? I thought it was a typo.
>

I apologize - it's my double blunder - HWMon shows Winbond W83627DHG=20
chip. So I tried w83627dhg driver and it perfectly works on my system=20
when loaded this way (as you suggested in a previous letter):

modprobe w83627ehf force_id=3D0xa020

w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:       +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.85 V  (min =3D  +0.69 V, max =3D  +1.91 V)
AVCC:        +3.39 V  (min =3D  +2.00 V, max =3D  +0.56 V)   ALARM
VCC:         +3.39 V  (min =3D  +2.86 V, max =3D  +1.76 V)   ALARM
in4:         +0.05 V  (min =3D  +1.53 V, max =3D  +1.94 V)   ALARM
in5:         +1.71 V  (min =3D  +1.32 V, max =3D  +1.86 V)
in6:         +0.05 V  (min =3D  +1.66 V, max =3D  +1.90 V)   ALARM
3VSB:        +3.49 V  (min =3D  +1.50 V, max =3D  +2.99 V)   ALARM
Vbat:        +3.34 V  (min =3D  +3.71 V, max =3D  +3.74 V)   ALARM
fan1:          0 RPM  (min =3D  217 RPM, div =3D 64)  ALARM
fan2:       1004 RPM  (min =3D  397 RPM, div =3D 32)
fan3:          0 RPM  (min =3D  357 RPM, div =3D 64)  ALARM
fan4:          0 RPM  (min =3D   84 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D  703 RPM, div =3D 16)  ALARM
temp1:       +33.0=B0C  (high =3D -13.0=B0C, hyst =3D -46.0=B0C)  ALARM  =
sensor =3D=20
thermistor
temp2:       +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
temp3:      +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D=20
thermistor
cpu0_vid:   +0.000 V

However this means two things, w83627ehf driver needs to be updated to=20
work with my PC (I can send any system information if it's required) and=20
sensors-detect script should also be modified to correctly identify my=20
sensors (it missed coretemp driver altogether).

***

coretemp driver started working after I applied the attached patch,=20
however the readings are wrong, so probably this driver is not yet=20
capable of monitoring Intel Core i5 650 CPU (temperatures are all wrong,=20
there are only two physical CPU cores):

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +23.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +26.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +23.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +26.0=B0C  (high =3D +84.0=B0C, crit =3D +100.0=B0C)

Thank you very much, Jean, for your invaluable help.

--=20

Best wishes,

Artem

--------------030109070806010504060406
Content-Type: text/plain;
 name="coretemp.intel.core.i5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="coretemp.intel.core.i5.patch"

--- coretemp.c.default	2010-02-18 16:14:58.517835386 +0500
+++ coretemp.c	2010-02-18 15:54:35.128157728 +0500
@@ -460,7 +460,7 @@
 		    !((c->x86_model == 0xe) || (c->x86_model == 0xf) ||
 			(c->x86_model == 0x16) || (c->x86_model == 0x17) ||
 			(c->x86_model == 0x1a) || (c->x86_model == 0x1c) ||
-			(c->x86_model == 0x1e))) {
+			(c->x86_model == 0x1e) || (c->x86_model == 0x25))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */

--------------030109070806010504060406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030109070806010504060406--
