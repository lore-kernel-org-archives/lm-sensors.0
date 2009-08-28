From: Karl Schmidt <karl@xtronics.com>
Date: Fri, 28 Aug 2009 18:36:18 +0000
Subject: [lm-sensors] Creating alarm for fans
Message-Id: <4A9823A2.2010907@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I hope this isn't a stupid question -but google didn't get me there..

Please cc -- I'm off list..

I used to be able to get an alarm for fans - but now I don't.


chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"

# Voltage inputs
# Depending on the hardware setup, the ADT7463 may not have in4.
    label in0   "V1.5"      # AGP on Intel S845WD1-E
    label in1   "VCore"
    label in2   "V3.3"
    label in3   "V5"
    label in4   "V12"

# Temperature inputs
    label temp1  "CPU Temp"
    label temp2  "Board Temp"
    label temp3  "Remote Temp"

# Fan inputs
    label fan1   "CPU_Fan"
    label fan2   "Fan2"
    label fan3   "Fan3"
    label fan4   "Fan4"
set fan1_min 8000




lm85b-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
V1.5:        +1.30 V  (min =3D  +0.00 V, max =3D  +3.32 V)
VCore:       +1.42 V  (min =3D  +0.00 V, max =3D  +2.99 V)
V3.3:        +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V5:          +5.08 V  (min =3D  +0.00 V, max =3D  +6.64 V)
V12:        +12.06 V  (min =3D  +0.00 V, max =3D +15.94 V)
CPU_Fan:    7837 RPM  (min =3D 8000 RPM)
Fan2:       8169 RPM  (min =3D    0 RPM)
Fan3:       7964 RPM  (min =3D    0 RPM)
Fan4:       7917 RPM  (min =3D    0 RPM)
CPU Temp:    +37.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
Board Temp:  +26.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
Remote Temp: +23.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)


2.6.26-2-amd64 #1 SMP


---------------------------------------------------------------------------=
-----
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

Assumption is the mother of mistakes.
Buckaroo Banzai

---------------------------------------------------------------------------=
-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
