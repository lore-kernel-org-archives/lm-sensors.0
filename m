From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: gl518sm
Message-Id: <20020205161336.N19496@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020205121432.I19496@Stimpy.netroedge.com>
In-Reply-To: <20020205121432.I19496@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Humm, if eeprom.o is working, then you should get something like this 
(I have two DIMMs in this case, so two eepoms):

[admin@Dust-Puppy admin]$ cat /proc/sys/dev/sensors/chips
256     eeprom-i2c-0-50
257     eeprom-i2c-0-51

[admin@Dust-Puppy admin]$ ls -l  /proc/sys/dev/sensors/*
/proc/sys/dev/sensors/eeprom-i2c-0-50:
total 0
-r--r--r--    1 root     root            0 Feb  5 16:13 data0-15
-r--r--r--    1 root     root            0 Feb  5 16:13 data112-127
-r--r--r--    1 root     root            0 Feb  5 16:13 data16-31
-r--r--r--    1 root     root            0 Feb  5 16:13 data32-47
-r--r--r--    1 root     root            0 Feb  5 16:13 data48-63
-r--r--r--    1 root     root            0 Feb  5 16:13 data64-79
-r--r--r--    1 root     root            0 Feb  5 16:13 data80-95
-r--r--r--    1 root     root            0 Feb  5 16:13 data96-111
 
/proc/sys/dev/sensors/eeprom-i2c-0-51:
total 0
-r--r--r--    1 root     root            0 Feb  5 16:13 data0-15
-r--r--r--    1 root     root            0 Feb  5 16:13 data112-127
-r--r--r--    1 root     root            0 Feb  5 16:13 data16-31
-r--r--r--    1 root     root            0 Feb  5 16:13 data32-47
-r--r--r--    1 root     root            0 Feb  5 16:13 data48-63
-r--r--r--    1 root     root            0 Feb  5 16:13 data64-79
-r--r--r--    1 root     root            0 Feb  5 16:13 data80-95
-r--r--r--    1 root     root            0 Feb  5 16:13 data96-111

Also look at /proc/bus/i2c.  Again, mine says:

[admin@Dust-Puppy admin]$ cat /proc/bus/i2c
i2c-0   smbus           SMBus PIIX4 adapter at 1040 Non-I2C SMBus adapter

What does lspci say?  (or 'cat /proc/pci')

Oh, and try 'insmod i2c-isa' in case your chip is on the ISA bus.
Hopefully, sensors-detect will try to detect and give hints on this
stuff.


Phil

On Thu, Feb 06, 2003 at 01:07:59AM +0100, Franssens wrote:
> Hey!
> 
> well, I'm not sure how to find out wether I have a i2c supported bus host.
> I use piix4, because it's a pentiumII :)
> the syslog did not contain errors.
> in /proc/sys/dev/sensors there is a file called "chips", which is an empty
> file.
> 
> by the way;
> eeprom.o IS fully supported.
> It also produces output when I try sensors.
> But it only contains RAM (?) information;
> something I'm really not interested in :)
> 
> further, I want to compliment you for your quick responses.
> I've never seen a software-designer answering questions this fast!  :)
> 
> thnx!
> greetz,
> Anne
> 
> 
> ----- Original Message -----
> From: <phil@netroedge.com>
> To: "Franssens" <dirkleni@rendo.dekooi.nl>; <sensors@Stimpy.netroedge.com>
> Sent: Tuesday, February 05, 2002 11:26 PM
> Subject: Re: gl518sm
> 
> 
> >
> > Do you have a supported I2C bus host?  Did you check the syslog for
> > possible errors?  Is there anything in /proc/sys/dev/sensors?  (That's
> > where the files are which have the raw sensor data.)
> >
> >
> > Phil
> >
> > On Wed, Feb 05, 2003 at 11:20:50PM +0100, Franssens wrote:
> > > I'm sorry,
> > >
> > > in my previous email (just sent it)
> > > I forgot one module.
> > > Here's my new output:
> > >
> > > Module                  Size  Used by
> > > gl518sm                 8096   0  (unused)
> > > i2c-proc                6064   0  [gl518sm]
> > > i2c-dev                 3712   0
> > > i2c-philips-par         2256   0  (unused)
> > > parport                24192   0  [i2c-philips-par]
> > > i2c-algo-bit            7712   0  [i2c-philips-par]
> > > i2c-piix4               3824   0
> > > i2c-isa                 1216   0  (unused)
> > > i2c-core               13328   0  [gl518sm i2c-proc i2c-dev i2c-algo-bit
> > > i2c-piix4 i2c-isa]
> > > root@Enterprise:~# sensors -s
> > > No sensors found!
> > >
> > >
> > > greetz,
> > > Anne
> > >
> > >
> > >
> > >
> > >
> > > ----- Original Message -----
> > > From: <phil@netroedge.com>
> > > To: "Franssens" <dirkleni@rendo.dekooi.nl>;
> <sensors@Stimpy.netroedge.com>
> > > Sent: Tuesday, February 05, 2002 9:14 PM
> > > Subject: Re: gl518sm
> > >
> > >
> > > >
> > > > I don't see a bus driver listed.  In order to communicate with your
> > > > chip (a GL518SM, I presume), you need a i2c bus driver which supports
> > > > your hardware installed.  Assuming you have a PIIX4, a good start
> > > > might be to insmod i2c-piix4.  Good luck!
> > > >
> > > >
> > > > Phil
> > > >
> > > > On Wed, Feb 05, 2003 at 09:18:15AM +0100, Franssens wrote:
> > > > > I'm having quit some difficulties with lm-sensors.
> > > > > Everything, including installing and compiling worked great,
> > > > > but now it doesn't seem to recognize my gl518sm detectors.
> > > > > when I modprobe that module,
> > > > > and then perform a "sensors -s", it says; no sensors found!.
> > > > > But it really IS listed on your supported hardware page.
> > > > >
> > > > > some help:
> > > > > motherboard: FullYes (82440lx), pentiumII 300HMz, 96MB RAM.
> > > > >
> > > > > lsmod:
> > > > > Module                  Size  Used by
> > > > > gl518sm                 8096   0  (unused)
> > > > > i2c-proc                6064   0  [gl518sm]
> > > > > i2c-dev                 3712   0
> > > > > i2c-core               13328   0  [gl518sm i2c-proc i2c-dev]
> > > > >
> > > > > the problem was, that sensordetect did not detect that gl518sm,
> > > > > but a piix4 an an eeprom.
> > > > > The only output sensors would give me then, was some info from
> eeprom,
> > > > > NOT voltages or fans etc.
> > > > > then I manually tried to modprobe gl518sm, with success. (as you can
> > > see)
> > > > > but unfortunately;
> > > > > sensors -s now says: no sensors found!
> > > > >
> > > > > can you help me?
> > > > >
> > > > > thnx!
> > > > > Anne
> > > >
> > > > --
> > > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > > >
> >
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> >

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
