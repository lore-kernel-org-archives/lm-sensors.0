From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: ASUS P4S333
Message-Id: <20020227180239.A24638@mercury.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020219105403.A1721@mercury.solarsys.net>
In-Reply-To: <20020219105403.A1721@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello mds, list:

> If the 8707 is on the isa bus hopefully you can see it
> with 'isadump 0x295 0x296'.

Nope.

> If it is on the ASB100 i2c bus you are out of luck.

Maybe not... remember there's a SMBus connector on the board.
Is there any reason I can't wire it to the parallel port and
use the i2c-pport driver?  I hope the 8707 is on the same bus.
I think I'll try that this weekend.

Also, please add me to the sensors mailing list.

Thanks and regards,

Mark

-- 
Mark M. Hoffman
mhoffman@lightlink.com

On Tue, Feb 26, 2002 at 09:37:58PM -0500, Mark D. Studebaker wrote:
> thanks for the info.
> I added 645 blacklist to CVS.
> If the 8707 is on the isa bus hopefully you can see it
> with 'isadump 0x295 0x296'.
> If it is on the ASB100 i2c bus you are out of luck.
> Don't expect Asus to reply.
> mds
> 
> "Mark M. Hoffman" wrote:
> > 
> > Hello mds, list:
> > 
> > Here is what information I have for the Asus P4S333 mainboard:
> > 
> > SiS645/SiS961
> > 
> > This pair is misdetected as SiS5595 like many other SiS chipsets.  Take a
> > look at the attached file for details.  I hope you get this soon enough to
> > "blacklist" it for 2.6.3.  I'll send a patch if you want but it's probably
> > just as easy to let you do it.
> > 
> > ITE 8707F
> > 
> > According to a marketing rep from ITE, this is a custom part for a
> > board maker - thus, no datasheets will be made available.  The good
> > news is: he told me that the hardware monitoring functions of the
> > chip are exactly as the 8712.  That said, I haven't been able to find
> > it w/ sensors-detect.  I'll post more when I get a chance.
> > 
> > ASB100 "Bach"
> > 
> > This is a custom ASIC by Asus that (I think) is the SMBus master.  I
> > haven't heard a peep out of Asus yet but I'll keep trying.  I would
> > really like to be able to use this because the board has a set of SMBus
> > pins.
> > 
> > Other vitals:  I'm using a stock RedHat kernel 2.4.9-21 and a CVS
> > snapshot post 2.6.2.
> > 
> > Also BTW... Some windows monitoring S/W came with the board; I really
> > don't believe what it reports about the CPU temp... always 40 C no
> > matter if the CPU is crunching Seti@home for hours or idle after a cold
> > boot.  The BIOS numbers do seem reliable though.
> > 
> > Regards,
> > 
> > Mark
> > 
> > --
> > Mark M. Hoffman
> > mhoffman@lightlink.com
> > 
> > 
> > 
> >    pci.txtName: pci.txt
> >           Type: Plain Text (text/plain)
