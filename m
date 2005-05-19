From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [tpx20@ja.olm.net: RE: TP EEPROM corruption in Linux]
Message-Id: <20020722095740.A16805@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Some good info from Joe!

----- Forwarded message from Joe in Australia <tpx20@ja.olm.net> -----

Reply-To: <tpx20@ja.olm.net>
From: "Joe in Australia" <tpx20@ja.olm.net>
To: <phil@netroedge.com>
Subject: RE: TP EEPROM corruption in Linux
Date: Mon, 22 Jul 2002 14:10:44 +1000
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20020721164017.F11600@Stimpy.netroedge.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SpamBouncer: 1.6 beta (6/22/02)
X-SBClass: OK

Hi Phil,

In my early experience with this TP saga back in December Last year, I did
see lots of posting as described by you below.

AT one stage I managed to get the same problem with the first TP I was
trying to unlock, { I did have the entire eeprom backed up before I started]

As I recall the CRC error was not fatal [The POST did not freeze the TP
although it looked like it at first], from memory, I searched the IBM web
site and found a reference to the problem.

The solution was to press the ESC key when the error was displayed [when it
looks as if the TP is stuck, gone to lunch], then boot to the OS, Windows
2000 in my case, do a restart [ not a cold boot] then do a normal shutdown,
problem went away.

Dealing specifically with your enquiry, I can see how it may be possible to
corrupt the eeprom.

Examine the 24RF08 data sheet carefully, and you will see that [designed to
be this way on purpose I believe to thwart attempt to read it as 24C08] the
sequence is very different to ordinary 24CXX and in fact that leads to the
eeprom being corrupted when being read [not being written to] as a 24Cxx.

"- Does the 24RF08 respond unfavourably to I2C 'quick' commands?  I.e.,
commands which stop after the first I2C byte (the address with r/w bit)."

My reply is YES, and I am certain about that.

Reason, I cannot remember exactly, have to revise the data sheets, but it
has to do with how 24RF08 sees the first TWO bytes as being the command and
address combined, so if you only send one byte, it is still expecting the
next byte that comes along as the second half of the address. Later when the
second byte arrives FROM ANYWHERE it is seen as the second byte of the
address to write to, and the next byte [the third byte] is the data to write
to that address.

It should be possible to come up with a sequence of 2 bytes and a STOP
command that would work on 24RF08 and other MORE NORMAL I2C devices.

All the models that have RFID use a 24RF08, other models use a 24C01 or
93C46 which do not support RFID.

All the models listed by you below use the 24RF08 [not sure about the 240].

Cheers
Joe

-----Original Message-----
From: phil@netroedge.com [mailto:phil@netroedge.com]
Sent: Monday, 22 July 2002 9:40 AM
To: tpx20@ja.olm.net
Cc: sensors@Stimpy.netroedge.com
Subject: TP EEPROM corruption in Linux



Hey Joe, I found your site and newsgroup postings while doing a little
research on a EEPROM corruption problem we're trying to solve under
Linux with the Lm_sensors project.

What seems to be happening is that users of these Thinkpad models are
getting CRC errors on boot, or a 'RFID serialization' error:

ThinkPad 770X
ThinkPad 600E
ThinkPad 770Z
ThinkPad 600X
ThinkPad 240
ThinkPad X20
ThinkPad 570E

I've got two questions which I'm trying to answer which you might be
able to help me with?

- Do all of these Thinkpad models listed above use a common EEPROM
chip? (e.g. an Atmel 24RF08)

- Does the 24RF08 respond unfavorably to I2C 'quick' commands?  I.e.,
commands which stop after the first I2C byte (the address with r/w
bit).

Our detection script tries to find all I2C busses and then all devices
on those busses using the I2C 'quick' command.  It then tries to
suggest which drivers to use for the platform.  It seems that after
detection and at the next reboot, the computer reports the errors I
mentioned above.  We're trying to figure out a way to avoid the
possibility of this kind of corruption in the future.

Thanks for any help you can provide!


Phil

--
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

----- End forwarded message -----

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
