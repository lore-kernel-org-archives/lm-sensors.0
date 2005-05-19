From: sig@netdot.net (Aaron VanDevender)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: SiS730
Message-Id: <1030900770.1578.103.camel@lazlo.netdot.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1030667598.1583.32.camel@lazlo.netdot.net>
In-Reply-To: <1030667598.1583.32.camel@lazlo.netdot.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2002-09-01 at 10:58, Mark D. Studebaker wrote:
> the to-be-written part is for the i2c bus driver, which you don't need
> for
> the it87 isa support.
> Did sensors-detect find the it87?

Yes it (usually) finds the it87. It sometimes finds the following:

Driver `lm78' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM78' (confidence: 7)

Driver `sis5595' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `Silicon Integrated Systems SIS5595' (confidence: 9)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

and sometimes it doesn't say anything about the lm87, and only detects
the sis5595 and the it87. Here's something weird though:

# modprobe i2c-isa; modprobe it87 temp_type=0x1c
# sensors -s; sensors
[Good Sensor information]
# rmmod it87
# modprobe lm78
# sensors -s; sensors
[Bad sensor information (-67?C) ]
# rmmod lm78; modprobe lm78
# sensors -s
No Sensors Found!

The lm78 driver only works immedietly after the it87 driver is unloaded,
but unloading and reloading lm78 doesn't find anything.

> What chip contains the hardware monitor? I looked at some SIS730 info
> on the web and couldn't find any reference to hardware monitor
> functions.

The hardware monitor is on an SiS950/ITE8705 chip. The SiS950 is their
"super I/O" chip. I can't find out much about it though. SiS dosen't
seem to have it listed on their website.

> 
> sig wrote:
> > 
> > I have an SiS730 sensor chip that I was able to get working using
> > lm_sensors-2.6.4, and I thought you guys might be interested in the
> > details. I used:
> > 
> > modprobe i2c-isa
> > modprobe it87 temp_type=0x1c
> > sensors -s
> > sensors
> > 
> > and I had to change some lines in /etc/sensors.conf. Under the it87
> > section, I told it to ignore temp3, and I reversed the labels of temp1
> > and temp2, so that temp1 is the CPU temp and temp2 is the System temp.
> > 
> > When I try to probe I get something like
> > 
> > Use driver `<To Be Written>' for device 00:00.0: Silicon Integrated
> > Systems SIS730 (To be written - Do not use 5595 drivers)
> > Use driver `i2c-sis5595' for device 00:01.0: Silicon Integrated Systems
> > SIS5595
> > Probe succesfully concluded.
> > 
> > We will now try to load each adapter module in turn.
> > Use of uninitialized value in string eq at
> > /usr/local/sbin/sensors-detect line 1000, <STDIN> line 1.
> > Use of uninitialized value in string eq at
> > /usr/local/sbin/sensors-detect line 1000, <STDIN> line 1.
> > 
> > [snip...]
> > 
> > but I just ignored all that and installed the modules as I said above,
> > and it works like a champ.
> > 
> > The Motherboard is an ECS K7SEM. The specs say it has an SiS730S chipset
> > with an integrated SiS 950/ITE8705 hardware monitor. It would be nice if
> > this chip were to work out of the box, so if you need someone to test
> > something, just let me know. Please CC any replies to me since I'm not
> > on this list.
> > 
> > cya
> > .sig
> > 
> > 
> >                        Name: signature.asc
> >    signature.asc       Type: application/pgp-signature
> >                 Description: This is a digitally signed message part
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 232 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020901/ad0e67b0/attachment.bin
