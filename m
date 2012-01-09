From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jan 2012 17:31:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] sensors-detect: Add detection of ITE
Message-Id: <20120109183128.16d988d9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326068484-1898-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326068484-1898-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 9 Jan 2012 09:02:56 -0800, Guenter Roeck wrote:
> On Mon, 2012-01-09 at 11:50 -0500, Jean Delvare wrote:
> > On Sun,  8 Jan 2012 16:21:22 -0800, Guenter Roeck wrote:
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  CHANGES                    |    1 +
> > >  prog/detect/sensors-detect |    6 ++++++
> > >  2 files changed, 7 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/CHANGES b/CHANGES
> > > index 3ae863c..ce04e54 100644
> > > --- a/CHANGES
> > > +++ b/CHANGES
> > > @@ -10,6 +10,7 @@ SVN HEAD
> > >                    Fix loading of the cpuid module
> > >                    Make LM73 detection less problematic
> > >                    Add detection of National Semiconductor LM96163
> > > +                  Add detection of ITE IT8510E
> > >  
> > >  3.3.1 (2011-07-21)
> > >    isadump: Add support for word (16-bit) and long (32-bit) reads
> > > diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> > > index 31a4619..1beb66b 100755
> > > --- a/prog/detect/sensors-detect
> > > +++ b/prog/detect/sensors-detect
> > > @@ -2076,6 +2076,12 @@ use constant FEAT_SMBUS	=> (1 << 7);
> > >  
> > >  @superio_ids_ite = (
> > >  	{
> > > +		name => "ITE IT8510E Super IO Sensors",
> > > +		driver => "to-be-written",
> > > +		devid => 0x8510,
> > > +		logdev => 0x04,
> > 
> > Are you sure about the logical device? LD 4 is "System Wake-Up"
> > according to superiotool, this doesn't seem to be related to hardware
> > monitoring. I think I understand that for the IT8510E, monitoring is
> > done through an EC, this doesn't seem to be tied to a specific logical
> > device? I admit I'm a bit confused by these new chips still.
> > 
> No, I am not sure. May be completely wrong, and is untested. I copied
> that value from one of the other ITE entries; they all use the same
> value for logdev. I don't even know what logdev is used for ;).

Logical devices refer to the different parts of Super-I/O chips, for
example parallel port, serial ports, hardware monitoring, RTC, watchdog
etc. Basically, every function which needs a separate I/O port range
corresponds to a logical device. Each logical device has a separate
configuration space, which can be selected using a global configuration
register.

> We should probably try to get some test coverage berfore committing the
> code.

Yes, please. Reading the datasheet should probably be a good idea as
well, even though it is no fun reading. These chips are so different
from what we support at the moment that we won't go anywhere without a
good amount of reading.

Note that the current superio detection code wants a logical device
number. If we start seeing devices which don't need/have one, we'll
have to revisit the code to make it optional.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
