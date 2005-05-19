From: sig@netdot.net (sig)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: SiS730
Message-Id: <1030667598.1583.32.camel@lazlo.netdot.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an SiS730 sensor chip that I was able to get working using
lm_sensors-2.6.4, and I thought you guys might be interested in the
details. I used:

modprobe i2c-isa
modprobe it87 temp_type=0x1c
sensors -s
sensors

and I had to change some lines in /etc/sensors.conf. Under the it87
section, I told it to ignore temp3, and I reversed the labels of temp1
and temp2, so that temp1 is the CPU temp and temp2 is the System temp.

When I try to probe I get something like

Use driver `<To Be Written>' for device 00:00.0: Silicon Integrated
Systems SIS730 (To be written - Do not use 5595 drivers)
Use driver `i2c-sis5595' for device 00:01.0: Silicon Integrated Systems
SIS5595
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Use of uninitialized value in string eq at
/usr/local/sbin/sensors-detect line 1000, <STDIN> line 1.
Use of uninitialized value in string eq at
/usr/local/sbin/sensors-detect line 1000, <STDIN> line 1.

[snip...]

but I just ignored all that and installed the modules as I said above,
and it works like a champ.

The Motherboard is an ECS K7SEM. The specs say it has an SiS730S chipset
with an integrated SiS 950/ITE8705 hardware monitor. It would be nice if
this chip were to work out of the box, so if you need someone to test
something, just let me know. Please CC any replies to me since I'm not
on this list.

cya
.sig
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 232 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020829/efc5b7f3/attachment.bin
