From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Pre-conference call information regarding lm_sensors
Message-Id: <20020720142336.D1076@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D38CA33.2E86DB9C@paradyne.com>
In-Reply-To: <3D38CA33.2E86DB9C@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


BTW- Keith was 'let go' after IBM dropped Linux support for Thinkpads.  
There was a /. article on it a little while ago:

http://slashdot.org/article.pl?sid/06/20/1631257&mode=thread&tid6


Phil



On Fri, Jul 19, 2002 at 10:25:55PM -0400, Mark D. Studebaker wrote:
> Attached is a mail from April 2001 on the issue of the sensors-detect
> script
> from lm_sensors corrupting the eeprom in IBM Thinkpads, which prevents
> them from booting.
> 
> As far as I know this conference call never happened.
> Nor do I have a record of receiving any response to the questions below.
> If any of you at IBM are still involved with Thinkpads we would
> like to  restart the discussion on how to prevent the corruption.
> Please contact us.
> 
> I will forward a second mail just after this one.
> 
> thanks
> mds
> 
> 
> "Mark D. Studebaker" wrote:
> > 
> > Keith, it would be very helpful if you could give us
> > the manufacturer and part number of the EEPROM on the PIIX4 bus,
> > and anything else that you think may be pertinent or unique to the
> > Thinkpad PIIX4 bus (SDA and SCK pullup values, SCK clock speed, ...)
> > 
> > thanks
> > mds
> > 
> > Frodo Looijaard wrote:
> > >
> > > Keith Frechette wrote:
> > > >
> > > > 1. ThinkPad thermal sensors are not accessible via the PIIX4 chip set.
> > >
> > > Yes, that much was already clear. That is fine. In a more general case,
> > > many things can potentially be attached to the PIIX4 SMBus adapter,
> > > ranging from temperature sensors to timer chips. The main problem
> > > is to somehow detect what is present.
> > >
> > > > 2. ACPI is the intended way of accessing the ThinkPad's sensors
> > >
> > > I am hardly an ACPI expert, so I may be way off here. The problem
> > > with ACPI as I have always understood it, is that it is BIOS-based,
> > > and that many BIOSes are plain buggy, not SMP safe, not interrupt
> > > safe, and generally hard to interface properly with Linux. Note
> > > that I am not saying that any of these problems are relevant for
> > > Thinkpads (I wouldn't know, as I have never used one), just that
> > > they are common for many systems. Also, non-IBM-compatible
> > > computers (macs, sparcs etc. etc.) generally don't have anything
> > > like the ACPI BIOS, and neither to older IBM-compatible computers.
> > > So in the general case, ACPI just does not cut it, and one has to
> > > use a lm_sensors-like solution anyway.
> > >
> > > In the case of the Thinkpads, life is fortunately simple. We
> > > can't access the H8 bus directly even if we wanted, due to a lack
> > > of documentation; so there is no chance of accidentally accessing
> > > the sensor chips directly, thereby triggering one of the
> > > nightmare scenarios you mentioned. Therefore, ACPI is the only way
> > > to do it (whether the Linux ACPI drivers are already advanced
> > > enough is another question entirely, which you would have to take
> > > up with the ACPI developers).
> > >
> > > As I see it, there remain two questions: why does the device that
> > > is on the PIIX4 bus get upset so easily disrupting your entire
> > > system, and how do we avoid it? I don't know whether you can or
> > > are allowed to answer the first question; still, any insight in
> > > what is happening under the lid may help us resolve any future
> > > problems. If there is any safer way to probe an PIIX4 adapter (or
> > > even better, any i2c or SMBus adapter in the more general case),
> > > I would dearly want to learn of it. But seeing the history of
> > > this bus (as far as I know, it was developed by Philips for embedded
> > > systems and appliances), I think it unlikely there is any failsafe
> > > method. I could argue that nothing a user does with his machine
> > > should have any bearing after a cold reboot and possibly a harddisk
> > > restore, at least not without setting a jumper on his mainboard
> > > (a common precaution against accidental or malicious reprogramming
> > > of your BIOS EEPROM), but that won't help us here. Still, I think
> > > it should be of concern to you that a (Windows) virus could easily
> > > disrupt the system on purpose in this way.
> > >
> > > > 3. lm_sensors can be modified to detect "ThinkPads" and to abort gracefully
> > >
> > > Though I would prefer finding some safe way to scan the PIIX4 bus,
> > > I suspect the best we can do is recognize the Thinkpad (perhaps
> > > through the PCI id of some always-there-but-never-on-anything-else
> > > device?) and simply not allow the PIIX4 driver to attach to it,
> > > or something like that (it may be enough to make certain i2c addresses
> > > unavailable; that is something that will have to be determined during
> > > the call, I think). As you are trying to free this information for
> > > public use, I think we should be able to resolve the symptoms of
> > > this problem without too much problem.
> > >
> > > Thanks,
> > >   Frodo
> > >
> > > --
> > > Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
> > > Defenestration n. (formal or joc.):
> > >   The act of removing Windows from your computer in disgust, usually followed
> > >   by the installation of Linux or some other Unix-like operating system.

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
