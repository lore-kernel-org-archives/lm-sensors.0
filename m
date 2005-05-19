From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: W83L785TS-S
Message-Id: <FJEPJHGHDGKMMPFFGCLOIEHBEIAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809120646.541e35a3.khali@linux-fr.org>
In-Reply-To: <20030809120646.541e35a3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean

yes it's supported but if I had known I would not have started it.  It's the
sensor the A7N8X COP feature works on, it's not supported by Asus probe and
I understand why by now :)

acording to all the posts and mails:

1) W83L785TS_S shows diode temp  Asus 1 shows case , Asus 2 shows socket
2) W83L785TS_S diode shows diode temp Asus 1 shows case , Asus 2 shows
socket
3) W83L785TS_S shows diode temp  Asus 2 shows case , Asus 1 shows socket
4) W83L785TS_S diode shows diode temp Asus 2 shows case , Asus 4 shows
socket

some board needs a reboot if switching between diode and normal readout ??!!
very version (and if I have to believe a few users) bios dependend

also it will timeout on the smbus, returning 0c, I am not sure if this is a
conflict with the bios reading it or not, I just know my smbus codes times
out.  To solves this, and I am NOT happy with it, I added a simple line for
this sensor that if it's 0 then give it the previous value.  I logged this a
while with a few users and it happens avarage about 2 times every 5 minutes,
sometimes an hour nothing then a few almost in a row

also as for detection it has the same ID as the W83L785TR so you never know
what you have :)  right now if I have no other primary sensor chip I asume
it's a W83L785TR, if I already have a primary then it probably is a
W83L785TS.

by now if people have problems with it (and I only know of the A7N8X using
it) I simply reply to search the forum and to remember there is a reason
asus probe does not support it

Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: zaterdag 9 augustus 2003 13:10
To: MBM Support
Cc: sensors@stimpy.netroedge.com
Subject: W83L785TS-S



Hi Alex,

Do you have support for the Winbond W83L785TS-S? Looks like it is needed
on the Asus A7N8X. I took a look at the datasheet, it seems to be a
rather simple one-temperature only chip, except that there are two
registers (at 53h and 85h) for temperature correction and limit
configuration. Damn Winbond, the datasheet is awfully poor and written
in a very approximative english. I just can't figure out what I'm
supposed to do with these registers. And of course I don't have that
chip handy, so I can't experiment myself. If you have any clue, it'll be
appreciated :)

Thanks.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
