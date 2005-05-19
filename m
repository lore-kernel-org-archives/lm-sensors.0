From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <3FC41BC2.933F17C9@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've added a 'c' mode to i2cdump in CVS.
If 'i2cdump 0 0x50 c' returns different data than 'i2cdump 0 0x50' then
the problem is in the nforce2 driver. Otherwise it's in eeprom.c.


Mark Studebaker wrote:
> 
> don't rule out a bus driver problem. They're both using nforce2.
> Note that i2cdump uses read_byte_data
> while eeprom.c writes the address then uses read_byte.
> There's also a couple of failure paths in eeprom that don't have
> printks.
> I'll add them to CVS now.
> 
> We have had previous reports (months ago) that the ddcmon driver
> was reading off-by-one, we never figured that out.
> This looks different though (off-by-slices).
> 
> mds
> 
> McClintock William J Contr MCOM wrote:
> >
> > > Then, unload the old eeprom module, load the new one, and do "cat
> > > /proc/sys/dev/sensors/eeprom-i2c-0-50/*" again. Then take a look at
> > > dmesg (or whichever log the debug stuff will have gone into), and tell
> > > me what you see there, from the moment the module was loaded. Hopefully,
> > > this will help me locate where the bug could hide.
> >
> > Hope this is it...
>
