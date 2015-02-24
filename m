From: Jay Foster <jayf0ster@roadrunner.com>
Date: Tue, 24 Feb 2015 16:26:44 +0000
Subject: Re: [lm-sensors] ITE 8620E Support
Message-Id: <54ECA644.4010805@roadrunner.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <543DD4BE.9000308@roadrunner.com>
In-Reply-To: <543DD4BE.9000308@roadrunner.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 2/24/2015 4:11 AM, Jean Delvare wrote:
> Hi Jay,
>
> On Tue, 14 Oct 2014 18:58:22 -0700, Jay Foster wrote:
>> I have a new Gigabyte Z97X-UD5H motherboard that has the ITE 8620E
>> chip.  I see on the wiki/Devices site that there is no driver for it.
>> The notes state that you can try loading the it87 module with the
>> force_id=3D0x8728 option.  I can confirm that this did succeed and senso=
rs
>> reports voltages and fan speeds.  I don't know if fan speed control work=
s.
> Thanks for the report. Can you please share the actual output of
> "sensors" with us?
>
I have also included a copy of my /etc/sensors.d/gigabyte.conf file to=20
apply labels to the fans I have hooked up.  The items commented out are=20
guesses.

/etc/sensors.d/gigabyte.conf:
# libsensors configuration file
# for Gigabyte Z97X-UD5H MB
# -----------------------------
#
# The it87.ko driver does not support the ITE 8620E chip.  The it87.ko
# driver is force loaded with the force_id=3D0x8728 option.  This is why
# both the it8728-* and it6820-* chips are listed here.
#

chip "it8728-*" "it8620-*"

# Fans
     label fan1 "CPU fan"
     set fan1_min 700

     label fan5 "Sys1 fan"
     set fan5_min 200

#    label fan4 "Sys2 fan"
#    set fan4_min 200

#    label fan3 "Sys3 fan"
#    set fan3_min 200

#    label fan2 "Sys4 fan"
#    set fan2_min 200

### temperatures

#    label temp1 "System temp" # tops at 33 degrees C
#    set temp1_min 10
#    set temp1_max 60

#    ignore temp2 # shows always 25 degrees C
#    set temp2_min 0
#    set temp2_max 60

#    label temp3 "CPU temp"
#    set temp3_min 10
#    set temp3_max 85

sensors output:
acpitz-virtual-0
Adapter: Virtual device
temp1:        +27.8=B0C  (crit =3D +105.0=B0C)
temp2:        +29.8=B0C  (crit =3D +105.0=B0C)

it8728-isa-0a30
Adapter: ISA adapter
in0:          +0.04 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +2.04 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in3:          +2.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in4:          +0.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.76 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.50 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +3.02 V
CPU fan:     2368 RPM  (min =3D  700 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
Sys1 fan:     543 RPM  (min =3D  200 RPM)
temp1:        +30.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp2:        +35.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp3:        +21.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
Intel PECI
intrusion0:  ALARM

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +30.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 0:         +30.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 1:         +29.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 2:         +25.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 3:         +28.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
