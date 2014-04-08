From: Pierre Kancir <pierre.kancir@gmail.com>
Date: Tue, 08 Apr 2014 14:13:00 +0000
Subject: Re: [lm-sensors] Ina219 with linux kernel driver
Message-Id: <CAK=2HV3pr31Sy+yRkKGh2YCCbHQhgTx58seXrn=fArpZQWt8WQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
In-Reply-To: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I am using beaglebone black default kernel, here is its informations :
Linux arm 3.8.13-bone40 #1 SMP Fri Jan 31 10:36:05 UTC 2014 armv7l
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D13.10
DISTRIB_CODENAME=3Dsaucy
DISTRIB_DESCRIPTION=3D"Ubuntu 13.10"

I modify devicetree as follow : in /boot/dtbs/

# generate the dts from the dtb
dtc -I dtb -O dts -o am335x-boneblack.dts am335x-boneblack.dtb

# modify the dts with a text editor  :

i add after cape_eeprom3@57 ( in i2c3 lines i2c@4819c000)

ina219@40 {
          compatible =3D "ti,ina219";
          reg =3D <0x40>;
          shunt-resistor =3D <100000>;
 };

# generate the dtb from the modified dts
dtc -I dts -O dtb -o am335x-boneblack.dtb am335x-boneblack.dts

#reboot the beaglebone black to load the new device tree

#use sensors
ubuntu@arm:~$ sensors
am335x-bandgap-isa-0000
Adapter: ISA adapter
temp1:        +53.0=B0C

ina219-i2c-1-40
Adapter: OMAP I2C adapter
in0:          +0.03 V
in1:          +4.94 V
power1:       12.74 W <- wrong value since not the good shunt resistor
value...
curr1:        +2.56 A  <- wrong value since not the good shunt resistor
value..



 *Kancir Pierre*
pierre.kancir@gmail.com
LinkedIn <http://www.linkedin.com/pub/pierre-kancir/4b/a1a/32a> |
Viadeo<http://www.viadeo.com/fr/profile/pierre.kancir>


2014-04-08 15:50 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:

> On 04/08/2014 06:29 AM, Pierre Kancir wrote:
>
>> Hi,
>>
>> I am trying to use ina219 sensor (http://www.adafruit.com/products/904)
>> with linux kernel driver on beaglebone black.
>>
>> I want to use device tree overlay to use the sensor. I follow kernel
>> indications (
>> http://lxr.free-electrons.com/source/Documentation/
>> devicetree/bindings/i2c/ina2xx.txt)
>> and the sensor works as expected.
>>
>> But adafruit board use 0.1ohms and default driver value for shunt-resist=
or
>> is 10mOhms so return value are wrong.
>>
>> I want to modify value in device tree as indicated
>>
>> ina219@40 {
>>            compatible =3D "ti,ina219";
>>            reg =3D <0x40>;
>>            shunt-resistor =3D <100000>;
>>   };
>>
>> but changing shunt-resistor value does nothing. The sensor is always
>> create
>> with 10mOhms value
>>
>> ina2xx 1-0040: power monitor ina219 (Rshunt =3D 10000 uOhm)
>>
>> How can i change the shunt-resistor value to get the proper return?
>>
>>
> Good question. This functionality was added mid-2013. What is your kernel
> version ?
>
> Guenter
>
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
