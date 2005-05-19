From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: i2c versioning
Message-Id: <3C043A85.BF5ECD23@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C043305.233767D@paradyne.com>
In-Reply-To: <3C043305.233767D@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You can do anything in code but I'm trying to call a function
that doesn't exist in 2.6.2 or earlier so I need
to do the comparison in the preprocessor in a #if statement
so I don't get an undefined symbol.


phil@netroedge.com wrote:
> 
> I think I originally had it like the kernel versioning scheme, but we
> changed it to be consistent.  I think Frodo (?) suggested putting
> version checking in the Makefile instead of in code.  What do you
> think of that?  BTW, when treated as a number, aren't the versionings
> still compariable?  E.g., "2.6.2" > "2.6.1"?
> 
> I'm glad we are thinking again about version checking.  It's a sore
> spot for most people installing Lm_sensors who have troubles.
> 
> Phil
> 
> On Tue, Nov 27, 2001 at 07:42:45PM -0500, Mark D. Studebaker wrote:
> > ok gang,
> > we now have rudimentary versioning in i2c.
> > i2c.h contains:
> >
> >       #define I2C_DATE "20011118"
> >       #define I2C_VERSION "2.6.2"
> >
> > now how am I supposed to use this in an ifdef?
> >
> > I want to add block read capability to eeprom,
> > but only if it's supported in i2c.
> >
> > So i need
> > #if I2C_VERSION > 2.6.2
> > i2c_smbus_i2c_block_read_data(...)
> > #else
> > regular read...
> > #endif
> >
> > but of course that doesn't work because I2C_VERSION is a string.
> >
> > Do we need something better, like three integers MAJOR, MINOR, whatever
> > like the kernel has?
> > Or can I do it somehow with strings?
> >
> > #ifdef I2C_VERSION
> > #if I2C_VERSION[0] * 100 + I2C_VERSION[2] * 10 + I2C_VERSION[4] > 262
> > ...
> > #endif
> > #endif
> 
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
