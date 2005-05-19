From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [tpx20@ja.olm.net: RE: TP EEPROM corruption in Linux]
Message-Id: <20020722102655.A28532@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020722095740.A16805@Stimpy.netroedge.com>
In-Reply-To: <20020722095740.A16805@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


A continuation of Joe's response.


----- Forwarded message from Joe in Australia <tpx20@ja.olm.net> -----

Reply-To: <tpx20@ja.olm.net>
From: "Joe in Australia" <tpx20@ja.olm.net>
To: <phil@netroedge.com>
Subject: RE: TP EEPROM corruption in Linux
Date: Mon, 22 Jul 2002 14:45:14 +1000
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20020721164017.F11600@Stimpy.netroedge.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SpamBouncer: 1.6 beta (6/22/02)
X-SBClass: OK

Hi Phil,

Further to my earlier response,

I will go through all my earlier stuff,

And given a couple of days, I will come back to you with an example of how
the 24RF08 is corrupted when treated as a 24CXX.

I know it doesn't seem possible, but it is, I have confirmed this myself,
but I just can't remember the exact circumstances.

I just had a look at the 24RF08, 24C01, 24C08 data sheets and I can't see
the problem [it doesn't jump out at you!], I know it's there and I have
confirmed it in the past, I just have to revisit the subject.

I do receive a lot of email from people who have corrupted their eeproms [TP
hangs CRC error, dead as a door nail] after having read the eeprom using IC
Prog or PonyProg and selected 24CXX as the eeprom type.

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
