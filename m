From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 13 Dec 2012 22:13:51 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20121213221351.GA563@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 13, 2012 at 02:27:57PM -0700, David Hubbard wrote:
> Hi Guenter,
> 
> On Thu, Dec 13, 2012 at 9:07 AM, Guenter Roeck <groeck-dsl@sbcglobal.net>wrote:
> 
> > On Thu, Dec 13, 2012 at 01:00:30AM -0700, David Hubbard wrote:
> > > I'd like to send the same patch again but add signed-off-by this time :)
> > I
> > > apologize.
> > >
> > > * * * * *
> > >
> > > Add experimental support for the it8603e chip (Asus f2a85-m motherboard)
> > > Write only tested for pwmN and pwmN_enable.
> > > Read tested, but the following appear broken:
> > >   alarms
> > >   fanN_alarm
> > >   inN_alarm
> > >   inN_max
> > >   inN_min
> > >   intrusionN_alarm
> > >   pwmN_auto_channels_temp
> > >   pwmN_freq
> >
> > I don't think it is a good idea to report attributes which "appear to be
> > broken". At least for the voltage limits and the alarms it should be
> > relatively
> > easy to find out if they work/don't work. Whatever doesn't work should not
> > be
> > there.
> >
> 
> They don't work but I don't know why. Until we have a datasheet, I'd like
> to leave them in the *experimental* driver and wait for a second opinion
> from someone who actually has the chip.
> 
> 
> >
> > >   temp3_input (there is no 3rd analog temp input to the chip)
> > >
> > Other IT87xx chips report the AMDSTI/PCH temperature as one of the inputs.
> > This
> > is usually configurable.
> >
> >
> Ok, fine with me.
> 
> Another question is to what extend we can depend on the logic in
> > it87_find() to
> > detect enabled chip features. It might make more sense to create another
> > if case
> > in that function to handle the IT8603 separately.
> >
> 
> it87_find() seems to have identified the correct features of the IT8603. I
> don't understand your concern with the way it is currently working.
> 
"they don't work ... " and "identified the correct features" seems to
somewhat contradict each other.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
