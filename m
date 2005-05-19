From: stefano@codesink.org (Stefano Barbato)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: EEPROM read/write user space program
Message-Id: <200311280048.12678.stefano@codesink.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122084059.0f9f73fa.khali@linux-fr.org>
In-Reply-To: <20031122084059.0f9f73fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've updated eeprog to display a big warning and a confirmation to continue. 
It's displayed for write AND for read operations because reading from an 8bit 
eeprom using 16bit addressing can actually *write* to the eeprom. 

I'll see block transfers whenever possible. I'll let you know for updates.

here is the download link:
   http://codesink.org/download/eeprog-0.7.4.tar.gz

stefano

p.s. if anybody is really willing to proofread this is the warning message :-)
=================================
__________________________________WARNING_______________________________
Erroneously writing to a system EEPROM (like DIMM SPD modules) can brake your
system.  It will NOT boot any more so you'll not be able to fix it.

Reading from 8bit EEPROMs (like that in your DIMM) without using the -8 switch
can also UNEXPECTEDLY write to them, so be sure to use the -8 command param 
when required.

Use -f to disable this warning message

Press ENTER to continue or hit CTRL-C to exit
=================================


On Sunday 23 November 2003 01:28, Mark Studebaker wrote:
> we have two programs, eeprom for small chips and eepromer for larger
> ones.
> They both suffer from the limitation you describe.
> As your program appears to overcome this limitation, and handle both
> small and large chips, I'd say it is worth including in our package.
>
> One thing we would require is that the program contains a big fat
> warning,
> and a force flag, before writing. See eeprom.c for an example.
>
> One suggestion you may want to think about is using i2c block reads and
> writes
> if the bus driver supports them. You can see the kernel/chips/eeprom.c
> driver
> for an example of this code.
>
> mds
>
> Stefano Barbato wrote:
> > Thanks Jean and hi to the mailing list.
> > I wrote to Jean because I wrote a program to read/write to EEPROMs using
> > the SMBus and I would like to share it.
> >
> > I found problems with 'eepromer' because it requires (based on my
> > understanding of the problem, mailing list comments will be very
> > appreciated:) a plain I2C capable bus.
> >
> > My chipset (viapro) is not able to send/recv plain I2C commands
> > (master_xfer is set to NULL into my adapter i2c_algorithm structure) but
> > it's able to use SMBus transfers and 'eeprog', the program I wrote, just
> > use SMBus commands.
> >
> > The result is that running 'eeprog' I can read/write to 24Cxx EEPROMs
> > with any SMBus bus adapter without requiring a plain I2C-capable chipset
> > while 'eepromer' or 'eeprom' on such systems will not work.
> >
> > I'm not an expert on the i2c topic so I'm not sure that my understanding
> > of the topic is, well, correct so if somebody here can confirm that
> > 'eepromer' has those limits and that 'eeprog' could be useful then I'll
> > be happy to know that I've not lost hours of my time for nothing :)
> >
> > thanks.
> >
> > stefano
> >
> > p.s. program URLs are quoted below.
> > ----------------------------------------
> > stefano barbato - stefano || codesink.org
> >
> > On Saturday 22 November 2003 08:40, Jean Delvare wrote:
> > > Hi Stefano,
> > >
> > > Please contact the mailing-list for general discussion, instead of me
> > > directly
> > >
> > > > I'm writing you because I wrote a Linux program to read and write
> > > > 24Cxx EEPROMs through the SMBus interface and want to share it with
> > > > the community (it's free of course).
> > > >
> > > > I wrote it because the 'eeprom' and 'eepromer' programs require a I2C
> > > > capable chipset (or, at least, this is what I think is the problem :)
> > > > and mine does not seem capable of I2C_RW (I'm using the viapro
> > > > driver).
> > >
> > > I don't get it. We have prog/eepromer/eepromer.c that is supposed to to
> > > the very same. In which way is your program different?
> > >
> > > I don't know what you mean with "I2C_RW", but all the bus drivers we
> > > have support sending data to the chips.
> > >
> > > > I think (and hope:) that eeprog (oh, it's called eeprog) url could be
> > > > included into a README in the eeprom dir or somewhere in lm-sensors
> > > > package so the next more-lucky-then-me can find it if needed.
> > > >
> > > > info link:
> > > >     http://codesink.org/eeprog.html
> > > >
> > > > download:
> > > >     http://codesink.org/download/eeprog-0.7.3.tar.gz
> > >
> > > If your program brings something really new, we will, but for now it
> > > seems to be just a duplicate of eepromer. It would be preferable to
> > > merge our efforts, isn't it? Please explain why eepromer did not work
> > > for you, and/or what eeprog does better.
> > >
> > > Mark D. Studebaker and some other persons on the list are much more
> > > knowledged about writing to eeproms than I am, and might be able to
> > > discuss it with you.
