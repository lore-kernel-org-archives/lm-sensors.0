From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: More flash eeprom fun on a Thinkpad
Message-Id: <20020721170111.G11600@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020721144141.C11600@Stimpy.netroedge.com>
In-Reply-To: <20020721144141.C11600@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 21, 2002 at 07:22:43PM -0400, Mark D. Studebaker wrote:
> The second link was the same as the first...

Oops!  Here it is:

http://groups.google.com/groups?q=thinkpad+770+crc&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm69C5256.520E1331%40premier1.net&rnum=1


Yeah, it could be a quick-write to 0x5C screwing things up (or a
module's probing routine).


Phil

> Looked closer at the datasheet.
> At 54-57 it is a standard 8K eeprom.
> But it also responds at 0x5c, where it has the access protection
> registers.
> My guess is that a write quick is trashing one of the access protection
> registers.
> But it could also be some probe in sensors-detect.
> 
> phil@netroedge.com wrote:
> > 
> > Some other related info:
> > 
> > A rant by Joe about the sensitivity of the Atmel 24rf08 causing
> > Thinkpads to go dead:
> > 
> > http://groups.google.com/groups?q=rfid+thinkpad&start&hl=en&lr=&ie=UTF-8&oe=UTF-8&selmS231e6e.0205061456.19e72ef2%40posting.google.com&rnum
> > 
> > A user describing his EEPROM getting fried on his TP770 when doing a
> > routine update (which wrote to the eeprom):
> > 
> > http://groups.google.com/groups?q=rfid+thinkpad&start&hl=en&lr=&ie=UTF-8&oe=UTF-8&selmS231e6e.0205061456.19e72ef2%40posting.google.com&rnum
> > 
> > Phil
> > 
> > On Sun, Jul 21, 2002 at 06:28:30PM -0400, Mark D. Studebaker wrote:
> > > Jackpot.
> > > It looks to me like a standard 8K I2C eeprom, but with an RF side as
> > > well.
> > > Not clear why they'd misbehave.
> > > I'll order some samples and we can play with them.
> > >
> > >
> > > phil@netroedge.com wrote:
> > > >
> > > > I found this interesting.  A guy took apart his Thinkpad 600X (one of
> > > > the lm-sensors vulnerable ones) and pulled out the Atmel Flash EEPROM
> > > > to reflash it:
> > > >
> > > > http://www.ja.olm.net/unlock/key_for_600x.htm
> > > >
> > > > You can get the datasheet for the AT24RF08C RFID flash eeprom here:
> > > >
> > > > http://www.ja.olm.net/unlock/key_for_600e.htm
> > > >
> > > > Strange serial eeprom device.  It lives in 0x54-0x57.  It's not clear
> > > > to me how the chip responds to 'quick' SMBus accesses we use during
> > > > probing, or how it would like being driven by our eeprom module.
> > > >
> > > > Anyways, note that people who have had their Thinkpad 240's killed by
> > > > Lm_sensors get the error: 0188: Invalid RFID Serialization Area
> > > >
> > > > Could we simply blacklist the 0x54-0x57 area unless the user
> > > > explicitly 'forces' regular usage of that area?
> > > >
> > > > Phil
> > > >
> > > > --
> > > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > 
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
