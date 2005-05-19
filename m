From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: call for 2.6.2 soon
Message-Id: <3BF1CFA3.5068FE5F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3BEB1CB9.B0136C74@paradyne.com>
In-Reply-To: <3BEB1CB9.B0136C74@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think we're ready to go.
martin did his change and I checked in Oleg's two patches and
did some other cleanup this weekend.

Phil, please do the honors at your convenience.
Emphasize on the home page and download page that i2c-2.6.2 is NOT
required
for kernels 2.4.13 or later.
Of course, users must enable "I2C /proc interface" in the kernel.

I'm happy to be back to where we were in January - no kernel patching
required for our users.

I'll do freshmeat a couple of days after the release.

thanks
mds






Mark Studebaker wrote:
> 
> 2nd call.
> I did the mkpatch update and the w83781d flag.
> 
> Let's say end of the day Sunday 11/11 to get things in.
> 
> Also, I would like to ensure that nothing, for a while, in lm_sensors requires
> the user to patch i2c if he has kernel 2.4.13 or greater.
> This way we can give our users a break and reduce the support tickets.
> 
> Any new drivers that require an ID please add
>         #ifndef I2C_DRIVERID_xxx
>         #define I2C_DRIVERID_xxx yyy
>         #endif
> to the driver and test against stock 2.4.13 or higher kernel.
> I did this for the first Fujitsu driver; Martin, would you please do it for yours.
> 
> Oleg, please let me know what patches go in on the i2c side.
> 
> mds
> 
> "Mark D. Studebaker" wrote:
> >
> > I'd like to put out a 2.6.2 release soon after kernel 2.4.13 is released
> > so we are synchronized with the kernel.
> >
> > Before that, on the sensors side,
> > I'm going to add some drivers to mkpatch in sensors and add
> > a no-initialize flag to w83781d to keep some boards from hanging.
> >
> > Anything else on the sensors side please check it in this week.
> > mds
