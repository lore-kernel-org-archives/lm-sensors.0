From: "Nicolas Krzywinski" <lists@site7even.de>
Date: Thu, 22 Oct 2009 17:36:33 +0000
Subject: [lm-sensors] Fwd: i801_smbus 0000:00:1f.3: Bus collision! SMBus may
Message-Id: <op.u17pu7fd5kimqn@sesta09.lan7even>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello again,

I rebooted a couple of days ago, but this log spam occured again.

What did I do wrong? Any tips?


What I wonder from the logs whether it may have something to do with gdm =20
because there are multiple sessions logged in all the time and the error =20
messages did not appear prior to this gdmlogin.

In those sessions there is a gnome applet activated that visualizes =20
processors frequency and temperature. Could this concurrent access lead to
	i801_smbus 0000:00:1f.3: Bus collision! SMBus may be locked until next =20
hard reset.
??


I will play around a little with logged in gdm sessions, maybe I get the =20
clue.

Any further help highly appreciated,
Nicolas


Log excerpt below:

Oct 17 00:18:20 server7even3 kernel: [ 3892.425346] gdmlogin[18400] =20
general protection ip:<ip> sp:<sp> error:0 in =20
libc-2.7.so[7fef3abe6000+14a000]
Oct 17 00:45:06 server7even3 kernel: [ 5763.151832] fglrx: module license  =

'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints =20
kernel.
Oct 17 00:45:06 server7even3 kernel: [ 5763.175373] [fglrx] Maximum main =20
memory to use for locked dma buffers: 11737 MBytes.
Oct 17 00:45:06 server7even3 kernel: [ 5763.175628] [fglrx]   vendor: 1002 =
=20
device: 954f count: 1
Oct 17 00:45:06 server7even3 kernel: [ 5763.175628] [fglrx] ioport: bar 4, =
=20
base 0xd000, size: 0x100
Oct 17 00:45:06 server7even3 kernel: [ 5763.175628] ACPI: PCI Interrupt =20
0000:08:00.0[A] -> GSI 30 (level, low) -> IRQ 30
Oct 17 00:45:06 server7even3 kernel: [ 5763.175628] PCI: Setting latency =20
timer of device 0000:08:00.0 to 64
Oct 17 00:45:06 server7even3 kernel: [ 5763.179877] [fglrx] Driver =20
built-in PAT support is enabled successfully
Oct 17 00:45:06 server7even3 kernel: [ 5763.179877] [fglrx] module loaded  =

- fglrx 8.56.4 [Dec  1 2008] with 1 minors
Oct 17 00:52:16 server7even3 kernel: [ 6282.075959] [fglrx] Gart USWC =20
size:192 M.
Oct 17 00:52:16 server7even3 kernel: [ 6282.075959] [fglrx] Gart cacheable =
=20
size:60 M.
Oct 17 00:52:16 server7even3 kernel: [ 6282.075959] [fglrx] Reserved FB =20
block: Shared offset:0, size:1000000
Oct 17 00:52:16 server7even3 kernel: [ 6282.075959] [fglrx] Reserved FB =20
block: Unshared offset:ff71000, size:8a000
Oct 17 00:52:16 server7even3 kernel: [ 6282.075959] [fglrx] Reserved FB =20
block: Unshared offset:fffb000, size:5000
Oct 17 00:55:00 server7even3 kernel: [ 6468.046637] =20
[fglrx:fireglAsyncioIntDisableMsgHandler] *ERROR* IRQMGR returned error 2  =

when trying to disable interrupt source ff00002c
Oct 17 00:55:00 server7even3 kernel: [ 6468.046646] =20
[fglrx:fireglAsyncioIntDisableMsgHandler] *ERROR* IRQMGR returned error 2  =

when trying to disable interrupt source ff00002d
Oct 17 00:55:00 server7even3 kernel: [ 6468.046656] =20
[fglrx:fireglAsyncioIntDisableMsgHandler] *ERROR* IRQMGR returned error 2  =

when trying to disable interrupt source ff00004e
Oct 17 00:55:00 server7even3 kernel: [ 6468.046661] =20
[fglrx:fireglAsyncioIntDisableMsgHandler] *ERROR* IRQMGR returned error 2  =

when trying to disable interrupt source 20000400
Oct 17 00:55:00 server7even3 kernel: [ 6468.046777] =20
[fglrx:fireglAsyncioIntDisableMsgHandler] *ERROR* IRQMGR returned error 2  =

when trying to disable interrupt source 10000000
Oct 17 00:55:00 server7even3 kernel: [ 6468.046788] =20
[fglrx:fireglAsyncioIntDisableMsgHandler] *ERROR* IRQMGR returned error 2  =

when trying to disable interrupt source ff000032
Oct 17 00:55:59 server7even3 kernel: [ 6535.352483] [fglrx] Gart USWC =20
size:192 M.
Oct 17 00:55:59 server7even3 kernel: [ 6535.352483] [fglrx] Gart cacheable =
=20
size:60 M.
Oct 17 00:55:59 server7even3 kernel: [ 6535.352483] [fglrx] Reserved FB =20
block: Shared offset:0, size:1000000
Oct 17 00:55:59 server7even3 kernel: [ 6535.352483] [fglrx] Reserved FB =20
block: Unshared offset:ff71000, size:8a000
Oct 17 00:55:59 server7even3 kernel: [ 6535.352483] [fglrx] Reserved FB =20
block: Unshared offset:fffb000, size:5000
Oct 17 01:06:47 server7even3 kernel: [ 7264.528506] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:08:59 server7even3 kernel: [ 7411.554854] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:13:15 server7even3 kernel: [ 7695.625746] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:16:43 server7even3 kernel: [ 7928.233496] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:24:07 server7even3 kernel: [ 8423.482129] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:44:39 server7even3 kernel: [ 9802.564245] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:45:11 server7even3 kernel: [ 9837.937025] CE: hpet increasing =20
min_delta_ns to 15000 nsec
Oct 17 01:48:59 server7even3 kernel: [10091.235014] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 01:53:59 server7even3 kernel: [10426.592868] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 02:16:52 server7even3 kernel: [11970.647939] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)
Oct 17 02:17:59 server7even3 kernel: [12044.613998] i801_smbus =20
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset. =20
(sorry!)




------- Weitergeleitete Nachricht -------
Von: "Nicolas Krzywinski" <lists@site7even.de>
An: lm-sensors@lm-sensors.org
Kopie:
Betreff: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision! SMBus may be =
=20
locked until next hard reset. (sorry!)
Datum: Tue, 15 Sep 2009 23:22:14 +0200

Hi,

just another desparate user that wrung out lm-sensors.org, Google & Co. ;-)

First of all: I don't really have a problem, because lm-sensors work on my
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

Remarks: ignored anything from lm78.. because I got only rubbish from
there - but Winbond works fine, nothing more that I need.

-----

Output of "sensors" command gives me pretty good values (except min/max
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
=3D Intel
PECI
temp6:       +49.0=B0C  (high =3D +100.0=B0C, hyst =3D +95.0=B0C)  sensor t=
hermistor
beep_enable:disabled

Remarks: don't wonder CPU temp, this is fully on load for more than 2 days
now ;-)

-----

Now, all that I need works thats good ... but lets have a look at my
kernel log:

me@myserver:~$ tail /var/log/kern.log
Sep 15 21:49:59 server7even3 kernel: [2670913.842602] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 22:13:48 server7even3 kernel: [2672347.037041] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 22:20:55 server7even3 kernel: [2672775.506601] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 22:28:04 server7even3 kernel: [2673204.696425] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 22:31:39 server7even3 kernel: [2673420.968805] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 22:37:15 server7even3 kernel: [2673757.521883] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 23:01:02 server7even3 kernel: [2675186.137306] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 23:03:58 server7even3 kernel: [2675362.459786] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 23:07:30 server7even3 kernel: [2675574.876593] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)
Sep 15 23:09:01 server7even3 kernel: [2675666.787660] i801_smbus
0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
(sorry!)


I do not really get to the point on what is causing those messages,
because:
- I got readings (any other occurrence of this message I found got no
sensor readings)
- I added only "ignores" to sensors3.conf (did I confused the kernel
because I ignored anything from lm78??)
- There is no time schema I can identify, the messages seem to occur
really arbitrary


What I did not do until now (I apologize, but have reasons):
- Restart of system (I don't want to restart because I think that message
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


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
