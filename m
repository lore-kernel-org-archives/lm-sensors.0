From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 31 May 2012 20:52:04 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of SMSC LPC47N217 and SIO10N268
Message-Id: <1338497524.478.120.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-05-31 at 15:53 -0400, Jean Delvare wrote:
> On Thu, 31 May 2012 11:00:46 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  CHANGES                    |    1 +
> >  prog/detect/sensors-detect |    8 ++++++++
> >  2 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/CHANGES b/CHANGES
> > index b08d205..8361883 100644
> > --- a/CHANGES
> > +++ b/CHANGES
> > @@ -7,6 +7,7 @@ SVN HEAD
> >    sensors-detect: Don't choke on systems without PCI
> >                    Avoid probing EDID addresses on graphics cards (#2386)
> >  		  Add detection of NCT6779D and NCT6102D/NCT6106D
> > +		  Add detection of SMSC LPC47N217 and SIO10N268
> >  
> >  3.3.2 (2012-03-14)
> >    libsensors: Added support for new sysfs attributes
> > diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> > index 6bfd1e2..df0e301 100755
> > --- a/prog/detect/sensors-detect
> > +++ b/prog/detect/sensors-detect
> > @@ -1904,6 +1904,10 @@ use constant FEAT_SMBUS	=> (1 << 7);
> >  		driver => "not-a-sensor",
> >  		devid => 0x28,
> >  	}, {
> > +		name => "SMSC LPC47N217 Super IO",
> > +		driver => "not-a-sensor",
> > +		devid => 0x7a,
> > +	}, {
> >  		name => "SMSC LPC47N227 Super IO",
> >  		driver => "not-a-sensor",
> >  		devid => 0x5a,
> > @@ -1911,6 +1915,10 @@ use constant FEAT_SMBUS	=> (1 << 7);
> >  		name => "SMSC LPC47N237 Super IO",
> >  		driver => "not-a-sensor",
> >  		devid => 0x13,
> > +	}, {
> > +		name => "SMSC SIO10N268 Notebook IO",
> > +		driver => "not-a-sensor",
> > +		devid => 0x5b,
> >  	}
> >  );
> >  
> 
> I didn't check the IDs but the "code" itself looks OK, please commit.
> 
Jean,

did you see the earlier patch I sent out a couple of weeks ago, adding
support to detect the new Nuvoton chips ? I would like to commit that
patch as well if it is ok with you.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
