From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: DMI detection
Message-Id: <20020801113135.I9662@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020724162451.F8689@Stimpy.netroedge.com>
In-Reply-To: <20020724162451.F8689@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think it was intended that DMI be used and availble to other 
parts of the kernel.  Not much (if anything) seems to use it yet, 
though.  I would think Alan would be pleased to make it available for 
us to hook into (if there isn't already some method).  It's also a 
much cleaner solution than copy-and-pasting all that code.


Phil


On Wed, Jul 31, 2002 at 10:24:16PM -0400, Mark D. Studebaker wrote:
> I've reconsidered the changes I put in i2c-piix4.c, which was
> essentially
> a copy of a portion of dmi_scan.c.
> Duplicating 200 lines of code from dmi_scan wouldn't be accepted as a
> patch.
> 
> If the char* array dmi_ident[] at line 145 of dmi_scan.c were
> un-"static"ed,
> and if the enum table just above that were moved to a header file,
> we could access the strings in the array to get the system vendor.
> Albert, if you can get this small patch accepted, then we are in good
> shape
> to submit clean sensors code as a patch later.
> 
> I'll move the code I just put into i2c-piix4 into a new dmi_scan module
> in our package.
> This will be used by people with kernels before 2.5.whatever,
> but it won't be in Albert's kernel patches.
> And this module can export the system vendor string somewhere,
> so that sensors-detect can just insert this module and get the string.
> Much easier than recoding the whole thing in perl.
> 
> Then eventually we can enhance the kernel dmi_scan to export the sensor
> information
> (the SM Bios table contains information on number and location of 
> voltage, temp, and current sensors, and fans).
> 
> Agreed???
> 
> 
> 
> "Mark D. Studebaker" wrote:
> > 
> > Great!
> > I'm taking the code from drivers/char/i8k.c
> > (which appears unchanged from at least kernels 2.4.17 through 2.5.28)
> > starting at line 502 through lines 662.
> > 
> > You should look at that code, and also at Alan's userspace program
> > dmidecode.c
> > http://www.domsch.com/linux/patches/dmi/
> > and decide which is the best place to start for you.
> > 
> > Jean Delvare wrote:
> > >
> > > > I'm going to work on putting DMI detection in i2c-piix4.
> > > > Any voluteers for doing the same in perl for sensors-detect? (please!)
> > >
> > > I know Perl rather good, I will help as much as I can. If the only thing
> > > to do is C-to-Perl translation, I'm on it :)
> > >
> > > --
> > > Jean "Khali" Delvare
> > > http://www.ensicaen.ismra.fr/~delvare/

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
