From: phil@ren.netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: [ltp] Installing linux, fear of lm_sensors
Message-Id: <Pine.LNX.3.96.1030105162839.3796D-100000@Ren.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



2.6.0 has the Thinkpad/IBM hardware detect stuff and it's been confirmed
by our IBM person, right? 


Phil

On Sat, 4 Jan 2003, Jim Harvey wrote:

> Philip Edelbrock wrote:
> > 
> > FYI- The chip used in the particular laptops had a faulty state machine 
> > for interpreting I2C bus commands.  Under certain circumstances, the 
> > chip would interpret commands meant for other chips as a command for 
> > it's self to write data to it's memory.  IBM doesn't use the chip any 
> > more (the AT24RF08, if I remember correctly), but it's still a problem 
> > with old hardware. :'(
> > 
> > Newer distros should begin to carry newer versions of lm-sensors which 
> > detects for potentially vulnerable IBM hardware and disable it's self.> 
> > Phil
> >
> > James Mckenzie wrote:
> > 
> >> Andrey:
> >>
> >> The problem with lm sensors is that it attempts to read the BIOS EPROM
> >> and messes it up.
> 
> Do you know what version of lm-sensors has that fix, and has it been verified
> that it in fact, works?  I'm using RH 8.0 here.  I tried to uninstall the
> lm-sensors rpm per a previous post's suggestion and it failed due to a KDE
> dependancy.
> -- 
>   After Armageddon, there will be only three things left: Kudzu vines creeping
>   over the ruins, Cockroaches feasting on the blackened ashes, and somewhere
>   an IBM PC saying "Abort, Retry, Ignore -- Abort, Retry, Ignore -- Abort... "
>   Jim Harvey - WB8NBS/9 - Naperville, Illinois - Linux on a Thinkpad 770Z
> 
> -- 
> The linux-thinkpad mailing list home page is at:
> http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
> 
