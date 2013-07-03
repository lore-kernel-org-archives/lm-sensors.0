From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 02:52:30 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6791D
Message-Id: <20130703025230.GA2282@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 02, 2013 at 09:10:52AM -0700, David Bartley wrote:
> The value of CR[20]/CR[21] on my board is 0xc8/0x03, and the physical chip
> itself has "NCT6791D" printed on it.
> 

Hi Jean and David,

Nuvoton confirms that 0xc803 is the correct chip ID.

Thanks,
Guenter

> 
> On Tue, Jul 2, 2013 at 7:36 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Tue, Jul 02, 2013 at 10:24:22AM +0200, Jean Delvare wrote:
> > > Hi Guenter,
> > >
> > > On Mon, 24 Jun 2013 13:19:39 -0700, Guenter Roeck wrote:
> > > > New superio chip, found on recent ASUS boards.
> > > >
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > >  CHANGES                    |    1 +
> > > >  prog/detect/sensors-detect |    7 +++++++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/CHANGES b/CHANGES
> > > > index 7036afe..b264f41 100644
> > > > --- a/CHANGES
> > > > +++ b/CHANGES
> > > > @@ -6,6 +6,7 @@ SVN HEAD
> > > >    sensors-detect: Report built-in drivers as such
> > > >                    Use modules.builtin instead of /sys/module
> > > >                    Handle built-in modules properly
> > > > +                  Add detection of NCT6791D
> > > >
> > > >  3.3.4 (2013-05-27)
> > > >    sensors.conf.5: Mention "sensors -u" to get the raw feature names
> > > > diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> > > > index 94645dc..9c213b6 100755
> > > > --- a/prog/detect/sensors-detect
> > > > +++ b/prog/detect/sensors-detect
> > > > @@ -2063,6 +2063,13 @@ use constant FEAT_SMBUS      => (1 << 7);
> > > >             logdev => 0x0b,
> > > >             features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
> > > >     }, {
> > > > +           name => "Nuvoton NCT6791D Super IO Sensors",
> > > > +           driver => "nct6775",
> > > > +           devid => 0xC800,
> > >
> > > The datasheet says 0xC560. Who is right?
> > >
> > That would be the same as nct6779d, which seems unlikely. Driver code is
> > from David Bartley, who I am sure tested it with his board.
> >
> > David, can you comment ?
> >
> > Once we know for sure I'll get in touch with Nuvoton and ask for
> > clarification.
> >
> > Thanks,
> > Guenter
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
