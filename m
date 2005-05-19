From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [tpx20@ja.olm.net: RE: TP EEPROM corruption in Linux]
Message-Id: <20020723100302.D8689@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020722095740.A16805@Stimpy.netroedge.com>
In-Reply-To: <20020722095740.A16805@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


More great details from Joe!

----- Forwarded message from Joe in Australia <tpx20@ja.olm.net> -----

Reply-To: <tpx20@ja.olm.net>
From: "Joe in Australia" <tpx20@ja.olm.net>
To: <phil@netroedge.com>
Subject: RE: TP EEPROM corruption in Linux
Date: Tue, 23 Jul 2002 14:19:50 +1000
X-Security: MIME headers sanitized on Stimpy.netroedge.com
	See http://www.impsec.org/email-tools/procmail-security.html
	for details. $Revision: 1.129 $Date: 2001-04-14 20:20:43-07 
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20020722103622.B28532@Stimpy.netroedge.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SpamBouncer: 1.6 beta (6/22/02)
X-SBPass: Oversize-Leantagged
X-SBClass: OK

Hi Phil,



I have revised my notes, and I suspect the problem has to do with the
differences between the 24RF08 and other i2c eeproms handling of address
rollover within the chip and also initial i2c addressing generally.



The ATMEL data sheet for the 24RF08 is very badly written [perhaps done on
purpose and I am NOT a conspiracy theorist], it does NOT cover the entire
subject, it simply says the 24RF08 is compatible with 24C08 [isn't every i2c
eeprom compatible?] and it gives great detail on RF access to the eeprom but
very scant detail on i2c access, it does not detail the whole picture.



The 24RF08 data sheet is available from the ATMEL web site or use the link
on my manuals page at;



http://www.ja.olm.net/unlock/manuals.htm





That is for the official ATMEL 8 pin version, the 14 pin version used in
most later model TP's with ATMEL markings, according to ATMEL does NOT exist
{apparently this is an IBM custom made part], so there is no data sheet
according to ATMEL, only difference really is the pin layout from 8 to 14
pins with 6 pins not connected.



I have seen a copy of the ATMEL data sheet for the 14 pin version, it does
exist, I was NOT allowed to keep a copy of the 14 pin datasheet, I was
allowed to read it [with conditions] to ascertain the pin out and confirm
that the functionality is identical to the official 8 pin version.



In all think pads using either the 24C01 or 24RF08, the eeprom always start
at i2c address A8 [all values in hex in this email]



The 24RF08 is internally hardwired to address A8, the 24C01 is externally
wired on the system board also to address A8.



The 24RF08 occupies address ranges [A8 00 to AE FF - 8 DATA PAGES-]  and [B8
00 to B8 0F] and [B9 00 to B9 0F]



Naturally It gets more complicated than that, as the B8 and B9 ranges
require each byte to be addressed individually and NACKed to acknowledge
receipt.



The RFID serialization is stored in page B9.



Page B8 location 0F contains the "device revision information" it is
hardwired, i.e it cannot be written to, and is usually, but not always 49
hex.





Some earlier model TP's don't do any checking of CRC of the eeprom data or
even for the presence of an eeprom, some will function quite happily with
the eeprom removed!



All the newer models BIOS gets very serious about CRC of the eeprom, one
mistake and it STOPS permanently! till the eeprom is replaced or
re-programmed correctly with all CRC(s) matching.







I presume your software is scanning the entire address range on the i2c bus
to detect any existing i2c devices.



I believe that if you are scanning for existing devices on the i2c bus, in
such a way as NOT TO inadvertently write to a 24RF08, you should;





1./ Issue an i2c address



2./ look for the ACK, signifying the presence of a responding i2c device.



3./ issue A STOP.



4./ Move onto the next address.







Obviously I have a spare 24RF08 outside of a TP to play around with, you
said in your email that you would try to get hold of one of these eeproms,
not easy to get believe me.



If you would like to send me an explanation of your sequence for scanning
the i2c bus, I only require your sequence of i2c commands.



I can try it on my spare 24RF08 and work out what is causing the problem and
perhaps arrive at a SAFE solution for you.





I suspect your problem may be that you do not issue a STOP command following
each attempt to address a device whilst looking for an ACK.



If you see the last image below, you will see that issuing a DEVICE
ADDRESS - [with R/W as 0] will leave the 24RF08 ready to interpret the next
byte as the address to write to and the following byte as the data to write
to that address.





I must say that you have been EXTREMELY lucky SO FAR !!!, as you only seem
to be writing to the RFID serialization area.



That error can be recovered from by pressing ESC doing a restart and then
then a shutdown, apparently BIOS resets the RFID serialization bytes [lucky
for us all].



BUT if you write to any byte in the first block of DATA pages in the 24RF08
that will cause a far more serious fatal error, where the TP detects a CRC
error, POST does not complete, the entire TP locks up and is useless until
the eeprom is either re-programmed with valid data or the eeprom is replaced
with one of those new security chips sold by various people on the net.



I think this whole messy saga with IBM and the 24RF08 is a very badly
thought out or maybe not thought out at all, design [using the term DESIGN
very loosely here], that is very easily corrupted during power failure, or
system crash, and of course IBM's answer is "replace the system board", show
us your wallet, we will gladly empty it for you!



Cheers

Joe.





24C01 Random read







24C08 Random read







24RF08 Write or Read - DATA -







24RF08 Access Protection pages







-----Original Message-----
From: phil@netroedge.com [mailto:phil@netroedge.com]
Sent: Tuesday, 23 July 2002 3:36 AM
To: Joe in Australia
Subject: Re: TP EEPROM corruption in Linux



Thanks for the great info!  Any other details you have would be
helpful, too, if you get a chance to dig through some notes.  What
you've given us to this point is really useful, though.

A team member is going to try to get some samples of the Atmel chip so
we can do some experiments.  In the mean time, when users install our
software, we can try to detect a Thinkpad and disable any access to
the bus which the 24RF08 is on.


Phil

On Mon, Jul 22, 2002 at 02:45:14PM +1000, Joe in Australia wrote:
> Hi Phil,
>
> Further to my earlier response,
>
> I will go through all my earlier stuff,
>
> And given a couple of days, I will come back to you with an example of how
> the 24RF08 is corrupted when treated as a 24CXX.
>
> I know it doesn't seem possible, but it is, I have confirmed this myself,
> but I just can't remember the exact circumstances.
>
> I just had a look at the 24RF08, 24C01, 24C08 data sheets and I can't see
> the problem [it doesn't jump out at you!], I know it's there and I have
> confirmed it in the past, I just have to revisit the subject.
>
> I do receive a lot of email from people who have corrupted their eeproms
[TP
> hangs CRC error, dead as a door nail] after having read the eeprom using
IC
> Prog or PonyProg and selected 24CXX as the eeprom type.
>
> Cheers
> Joe
>
> -----Original Message-----
> From: phil@netroedge.com [mailto:phil@netroedge.com]
> Sent: Monday, 22 July 2002 9:40 AM
> To: tpx20@ja.olm.net
> Cc: sensors@Stimpy.netroedge.com
> Subject: TP EEPROM corruption in Linux
>
>
>
> Hey Joe, I found your site and newsgroup postings while doing a little
> research on a EEPROM corruption problem we're trying to solve under
> Linux with the Lm_sensors project.
>
> What seems to be happening is that users of these Thinkpad models are
> getting CRC errors on boot, or a 'RFID serialization' error:
>
> ThinkPad 770X
> ThinkPad 600E
> ThinkPad 770Z
> ThinkPad 600X
> ThinkPad 240
> ThinkPad X20
> ThinkPad 570E
>
> I've got two questions which I'm trying to answer which you might be
> able to help me with?
>
> - Do all of these Thinkpad models listed above use a common EEPROM
> chip? (e.g. an Atmel 24RF08)
>
> - Does the 24RF08 respond unfavorably to I2C 'quick' commands?  I.e.,
> commands which stop after the first I2C byte (the address with r/w
> bit).
>
> Our detection script tries to find all I2C busses and then all devices
> on those busses using the I2C 'quick' command.  It then tries to
> suggest which drivers to use for the platform.  It seems that after
> detection and at the next reboot, the computer reports the errors I
> mentioned above.  We're trying to figure out a way to avoid the
> possibility of this kind of corruption in the future.
>
> Thanks for any help you can provide!
>
>
> Phil
>
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

--
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A








----- End forwarded message -----

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
