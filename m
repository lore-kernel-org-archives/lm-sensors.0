From: david-b@pacbell.net (david-b@pacbell.net)
Date: Thu, 14 Jul 2005 01:07:39 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <20050713230648.8C1FEBF411@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Which is _exactly_ what "eeprom" does.  If it's good enough
> > for that driver, it should be good enough here ...
>
> This ain't compatible, as you still need to provide the addresses while
> they are built-in for the "eeprom" driver. A really backward
> compatible driver would need to behave like the old driver did when no
> module parameter are provided.

I'm thinking full backward compat with "eeprom" is not necessarily
worth having as a goal.

One aspect of that is size sensing thing, where "eeprom" assumes
everything it sees is a 24c02 EEPROM (vs being told what's where),
and can use 8 bit addressing.  This is the wrong idea.  :)

Another is the various additional tweaks, like special support
to hide the VAIO password.  Simpler would be just to make that
data readable only by root.


> > though as I commented, "eeprom" mis-handles at least double byte
> > address cases, also chips of size != 2 Kbits, so maybe it's not really
> > "good enough" there.  ;)
>
> I think we really only need to be backward compatible with "eeprom" for
> the 24C02. This is the most popular EEPROM in consumer PCs.

What do you mean "compatible" ... never being writable?
Supporting the VAIO hack?  Having the same driver name?

Folk have said on this list before they don't think that the
"eeprom" driver is much more than an example. So I'm reasonably
sure that there's no point in being identical to it.  If both
drivers can provide an "eeprom" binary file -- that should be
close enough.


>	It's
> probably not a problem to break comaptibility for larger EEPROMs, as
> there are less users and these users (hopefully) knew better support
> could come later, which would imply incompatibility.

Ones using 16 bit addressing never worked before, so breaking
compatibility there is the topmost goal!  :)

Chips of 4, 8, or 16 Kbits being handled as one chip rather than
several chips is surely the better model, but that's the main
incompatibility I can see.

Other than saner support for smaller eeproms ... e.g. right now
the driver assumes everything's got 2Kbit capacity, which means
smaller eeproms (notably 1 Kbit and 128 bits) misbehave.



> > > Point (b): You could as well implement a generic function in i2c-core.
> > > I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 is already reserved for that in i2c.h,
> > > which suggests that SMBus 2.0 defines it (although I can't remember of
> > > any hardware implementimg it).
> >
> > If no SMBUS hardware implements it, I'm not sure what the point of
> > such a function would be!  For now, this version is portable enough.
>
> If nothing else, this could avoid code duplication (the max6875 driver
> needs something similar, for example). And hardware support might be
> added later, and we get immediate benefit.

So that'd be a capability that drivers would need to advertise,
and which would have a straightforward implementation in terms
of I2C primitives.  Sure.  No problem; that seems like a fine
thing to have.

If someone were to submit patches for this in the core, and
teaching my at24c driver how to work on SMBUS, then I suspect
we'd both be happier.  :)


> > Maybe an even better place for it would be in the I2C core,
> > by having the I2C drivers declare what level of functionality
> > it needs from the adapter?  One word of data in each driver
> > (taken from struct padding?) replacing several instructions
> > and fault paths ... moving to one fault path in the core.
>
> Exactly the conclusion I had come to. Just like adapter drivers can say
> what they can do, device drivers would say what they require for proper
> operation (but are still free to use more later for improved speed or
> whatever). I need to think about it some more. but that sounds promising
> for sure.
>
> (But I want to kill i2c-isa first, as it's in the way somehow.)

Take your time.  :)

Random side note:  I think an SPI driver framework might need the
same sort of thing, wherein drivers say what SPI mode(s) they need.


> > I'll remove group and "other" read access then; good point.
>
> If you do, you will never be compatible with the legacy eeprom driver.

That wasn't necessarily a good default choice.  FLASH eeproms
aren't normally world readable, for example.  Why should I2C
ones be?


> > However, the REALLY nice way to do this would be if the I2C bus
> > framework had a clean way to handle static device configuration
> > (like "platform_bus" does).  Then such a flag could be just one
> > of several bits of information provided to driver using driver
> > model infrastructure like platform_data.
>
> Where are the patches? ;)

The only bright idea I've had so far involves board-specific code
providing a platform pseudo-device whose platform_data would be
morphed (by a "pseudo-driver", registered and deregistered before
the "at24c" i2c driver) into the addr_data (and coupled fields) that
are currently used to init that i2c driver.

That's a bit hacky though.  Better if there were some real device
node that the at24c driver would bind to ... which would sort of
turn the current I2C model on its head.  

Or maybe not ... maybe a static I2C device tree could just be set
up early by board-specific code, and the I2C infrastructure could
view it as an alternate way to specify more "probe" or "force"
entries, without using module params.


> You might want to wait for the i2c-isa cleanup to happen first, as the
> i2c subsystem will be much cleaner and somewhat less sensors-centric
> after I am done.

Wasn't there some work afoot (Greg in his copious spare time?) to
make I2C play better in the driver model world?

- Dave

