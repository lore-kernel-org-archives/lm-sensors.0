From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Asus ASB100 chip information
Message-Id: <3D8D0513.C68FB178@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D88B3B2.2050400@zonnet.nl>
In-Reply-To: <3D88B3B2.2050400@zonnet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks,
let us know if you find out more.
mds

Bertrik Sikken wrote:
> 
> Hi again,
> 
> I experimented some more trying to read the registers in the
> undocumented range from 0x00 to 0x1F. There seem indeed to be
> several other interesting values. The values I read back are
> consistent between consecutive reads or some of them vary a
> bit over several reads. I think I can identify some as being
> voltage inputs. It does not look like that there is a simple
> relation between registers 0x00-0x1F and 0x20-0x3F.
> 
> Regards,
> Bertrik
> 
> Bertrik Sikken wrote:
> 
> > Hi all,
> >
> > I did some experiments with the ASB100 health monitoring chip
> > sitting on my Asus A7V333 motherboard.
> >
> > This chip is currently supported by the w83781d driver in
> > lmsensors 2.6.5, but the CPU temperature indicated by sensors
> > is different from the one shown in the BIOS (version 1013)
> > and the asusprobe utility under windows (v2.18.01).
> >
> > I found out that the CPU temperature (as indicated by the
> > BIOS and asusprobe) is stored in register 0x17.
> > This is in an area undocumented by the w83781d datasheet.
> > The lm78 datasheet indicates the area 0x00-0x1F as 'POST RAM'.
> >
> > Register 0x17 is exactly 0x10 positions away from the normal
> > temperature register at 0x27 as shown in the lm78 datasheet.
> > So I suspect there will be more interesting registers in this area
> > but have not tried them all yet.
> >
> > I won't mind doing some more experiments and I hope this info
> > is useful for improving ASB100 support.
> >
> > Kind regards,
> > Bertrik Sikken
> >
> >
> >
> >
> >
