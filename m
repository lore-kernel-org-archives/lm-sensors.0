From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <20020203184429.A25075@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


You know, I thought 57 was a funny address for your DIMM.  My guess is
that it is something else, as you are thinking.  In the past, Xeon
processors had a eeprom in them which appeared in addresses high like
57.  But, I'm still curious why only your first slot is detected and
your second is not.  Anyways, thanks for the detective work thus far!


Phil

On Sun, Feb 03, 2002 at 01:31:52PM -0500, Mark D. Studebaker wrote:
> The print_eeprom() code in prog/sensors/chips.c will only
> print out the SDRAM information if the chip is
> coded as an SDRAM, that is, location 0x02 contains 0x04.
> 
> If you send the output of either i2cdump or cat
> /proc/sys/dev/sensors/*eeprom*/*
> we can look at it.
> 
> mds
> 
> 
> Jean Delvare wrote:
> > 
> > I have been testing many things about my eeprom driver issue.
> > 
> > Tried reading 256 bytes instead of 128, in case both memory slots would
> > have been "serialized" in some way. No result.
> > 
> > Tried reading more than 256 bytes (320) to see if there were something
> > intersting there. In fact, it seems that we are wrapped back to offset 0
> > when moving past 256. No result.
> > 
> > Tried two other addresses detected on my i2c bus (namely 30 and 37). No
> > result (except turning the power off.)
> > 
> > Another thing to notice is that when I swap my two memory modules, the
> > (wrong) data at address 57 doesn't change at all.
> > 
> > My conclusion is that address 57 is *not* the secondary slot, which may be
> > simply not reachable. Maybe I will ask Sony people about that, but I doubt
> > I will obtain any information.
> > 
> > Thanks for your attention.
> > 
> > --
> >        /~~       Jean "Khali" Delvare
> >   -----\_                        mail: delvare@ensicaen.ismra.fr
> >  --------\                http://www.ensicaen.ismra.fr/~delvare/
> > ---=ISMRA/- ____________________________________________________

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
