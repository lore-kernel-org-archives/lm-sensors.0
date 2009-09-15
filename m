From: "Nicolas Krzywinski" <lists@site7even.de>
Date: Tue, 15 Sep 2009 21:22:14 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision! SMBus may be
Message-Id: <op.u0bhncaa5kimqn@sesta09.lan7even>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

just another desparate user that wrung out lm-sensors.org, Google & Co. ;-)

First of all: I don't really have a problem, because lm-sensors work on my =
=20
baby
But: There is some spamming in the kernel log (see subject and below)

-----

Now lets hear the details:

My system:
1x Intel Xeon DP E5506
..on Tyan S7002WGM2NR-LE (one CPU slot free)
..using KVR1066D3Q8R7SK3/12G as short-term memory
..with several SATA drives attached
..running Debian 2.6.26-17lenny2

As far as I understand aptitude, I installed:
lm-sensors 3.0.2-1+b2
..with libc6 2.7-18
..and libsensors4 3.0.2-1+b2
..and perl 5.10.0-19lenny2
..and sed 4.1.5-6

-----

What I modified in sensors3.conf:

[..]
chip "lm78-*" "lm79-*" "w83781d-*"
[..]
    ignore in0
    ignore in1
    ignore in2
    ignore in3
    ignore in4
    ignore in5
    ignore in6
[..]
     ignore fan1
     ignore fan2
     ignore fan3

    ignore temp1
    ignore cpu0_vid
[..]
chip "w83793-*"
[..]
    ignore fan6
    ignore fan7
    ignore fan8
    ignore fan9
    ignore fan10
    ignore fan11
    ignore fan12

    # This we have to reactivate when there is a second cpu installed..
    ignore temp2
    ignore temp5
[..]

Remarks: ignored anything from lm78.. because I got only rubbish from =20
there - but Winbond works fine, nothing more that I need.

-----

Output of "sensors" command gives me pretty good values (except min/max =20
but I'm not keen on that):

me@myserver:~$ sensors
lm78-i2c-0-2d
Adapter: SMBus I801 adapter at 0400

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
VCoreA:      +1.21 V  (min =3D  +0.00 V, max =3D  +2.05 V)
VCoreB:      +0.00 V  (min =3D  +0.00 V, max =3D  +2.05 V)
Vtt:         +1.09 V  (min =3D  +0.00 V, max =3D  +2.05 V)
in3:         +1.47 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:         +1.07 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:       +3.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+12V:       +11.71 V  (min =3D  +0.00 V, max =3D +24.48 V)
+5V:         +4.90 V  (min =3D  +0.15 V, max =3D  +6.27 V)
5VSB:        +4.88 V  (min =3D  +0.15 V, max =3D  +6.27 V)
VBAT:        +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
fan1:        525 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:        775 RPM  (min =3D    0 RPM)
fan4:       1131 RPM  (min =3D    0 RPM)
fan5:        703 RPM  (min =3D    0 RPM)
CPU1 Temp:   +71.2=B0C  (high =3D +100.0=B0C, hyst =3D +95.0=B0C)  sensor =
=3D Intel =20
PECI
temp6:       +49.0=B0C  (high =3D +100.0=B0C, hyst =3D +95.0=B0C)  sensor =
=3D =20
thermistor
beep_enable:disabled

Remarks: don't wonder CPU temp, this is fully on load for more than 2 days =
=20
now ;-)

-----

Now, all that I need works thats good ... but lets have a look at my =20
kernel log:

me@myserver:~$ tail /var/log/kern.log
Sep 15 21:49:59 server7even3 kernel: [2670913.842602] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 22:13:48 server7even3 kernel: [2672347.037041] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 22:20:55 server7even3 kernel: [2672775.506601] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 22:28:04 server7even3 kernel: [2673204.696425] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 22:31:39 server7even3 kernel: [2673420.968805] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 22:37:15 server7even3 kernel: [2673757.521883] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 23:01:02 server7even3 kernel: [2675186.137306] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 23:03:58 server7even3 kernel: [2675362.459786] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 23:07:30 server7even3 kernel: [2675574.876593] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Sep 15 23:09:01 server7even3 kernel: [2675666.787660] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)


I do not really get to the point on what is causing those messages, =20
because:
- I got readings (any other occurrence of this message I found got no =20
sensor readings)
- I added only "ignores" to sensors3.conf (did I confused the kernel =20
because I ignored anything from lm78??)
- There is no time schema I can identify, the messages seem to occur =20
really arbitrary


What I did not do until now (I apologize, but have reasons):
- Restart of system (I don't want to restart because I think that message  =

will come back)
- stopped sensord (because of the need to monitor the cpu temp, you know..)


Further:
- I installed phpsysinfo as well. Anything evil with that maybe?


Long story, short question: any hints?


Regards,
Nicolas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
