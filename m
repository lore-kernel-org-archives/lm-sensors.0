From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 12 May 2011 13:58:55 +0000
Subject: Re: [lm-sensors] [PATCH] Document existing support for SMSC EMC2300
Message-Id: <20110512135855.GA10934@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Thu, May 12, 2011 at 05:34:21AM -0400, Jean Delvare wrote:
> Hi Steve, Guenter,
> 
> On Wed, 11 May 2011 20:53:59 +0200, Steve.Glendinning@smsc.com wrote:
> > Hi all,
> >  
> > >Datasheet says that 0x20, 0x23, 0x24, 0x43..0x45, and 0x4a..0x4d are
> > >all
> > >zero on the EMC2300. Most interesting would be 0x45, 0x4b, and 0x4d,
> > >which are initialized with 0x00 on the EMC2300 but 0xff for the
> > >EMC6D103S.
> > The datasheet lies :-)
> >  
> > They return the same as the EMC6D103S, i.e. 0xff for 0x45, 0x4b, and 0x4d.
> 
> 0x43 is somewhat interesting. It corresponds to the VID pins the
> EMC2300 doesn't have, so this register will always return zero for the
> EMC2300. Unfortunately, most recent systems don't use the VID pins anyway 
> 
> > >> > EMC2300 doesn't have all the voltage inputs that EMC6D103S has,
> > >> > so reports in0, in3 and in4 all as zero.
> > >> 
> > >> Wouldn't this be good way to differentiate between the parts? What
> > >> values are returned by the EMC2300 for registers 0x20, 0x23, 0x24,
> > >> 0x44, 0x45, 0x4a, 0x4b 0x4c and 0x4d?
> > I thought of this, yes the missing voltage inputs all always return 0.
> 
> This isn't what the dump you just sent shows:
> 
> > 20: bf ff ff ff ff ff 00 ff dd 02 ff ff ff ff ff ff    ?.......??......
> 
> Values are 0xbf, 0xff and 0xff respectively for registers 0x20, 0x23
> and 0x24. 0xbf is odd.
> 
> More surprisingly, register 0x22, which contains the voltage of the
> monitoring chip itself, reads 0xff... Ah, I get it. On this dump,
> monitoring isn't enabled (bit 0 of register 0x40 is 0).
> 
> Steve, can you please enable monitoring and provide a new dump?
> 
> # modprobe i2c-dev
> # i2cset -m 0x01 3 0x2e 0x40 0x01 b
> # sleep 1
> # i2cdump 3 0x2e b
> 
> This means that we can't differentiate between EMC6D103S and EMC2300
> before monitoring is started. D'oh. So I'll commit your sensors-detect
> patch right away, as we can't enable the chip there, so your patch it
> the best we can have there (and we don't need anything better anyway -
> both chips are supported by the same driver.)
> 
> >  I don't have an EMC6D103S handy though, so I'm not able to check its behaviour if those pins are either not connected or connected to ground.  Presumably it could also return 0 in some cases so the detection would not be 100% foolproof?
> 
> Correct, but OTOH, if inputs are grounded or unconnected, users won't
> care about them, will they? I think there is value in not exporting
> channels which do not exist, to make configuration easier for the user
> (and make runtime somewhat more efficient.) The downside is more
> complex code in the lm85 driver.
> 
> > I figured the safe option was to leave the extra inputs visible, as I didn't want to risk blocking access to them on parts where they're present.
> 
> This is certainly the easiest option. There's indeed a risk in trying
> to refine the detection and we won't do it if that can't be done
> reliably. But my main concern at this point is the increased driver
> complexity.
> 
I suspect that the EMC2300 has the same chip core as the EMC6D103S
with different pinout. Given that, and the complexity of driver changes
necessary to deal with the unsupported sensors, maybe the original patch 
is the best way to go after all.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
