From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: as99127f additional temps
Message-Id: <20040114024104.GI894@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040110134945.6e58ea97.khali@linux-fr.org>
In-Reply-To: <20040110134945.6e58ea97.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-01-10 13:49:45 +0100]:
> Hi all,
> 
> >From what I see in the w83781d driver, it is assumed that the as99127f
> extra temperatures are 9 bit signed values with LSB = 0.25 degree C (as
> opposed to LSB = 0.5 degree C in other winbond chips and lm75 itself).
> 
> What reason do we have for such an assumption?
> 
> I think we are wrong here, for the following reasons:
> 
> 1* Asus chips are known to be copied from Winbond ones. I don't see any
> reason they would change the LSB value. What's more, MMH's asb100 driver
> uses standard lm75 conventions.
> 
> 2* For all boards using the as99127f, a conversion is needed for temp2
> and temp3 (which is not that frequent AFAIK), and the default is:
>     compute temp2 @*2.0, @/2.0
>     compute temp3 @*2.0, @/2.0
> Which brings us back to a 0.5 LSB. I know that Asus are the recognized
> international champions of senseless temperature conversions (as I have
> experienced on my TX97-E) but let's not charge them with something they
> probably haven't done.
> 
> So I propose that we use standard lm75 conversions for the as99127f
> subclients. This will simplify the code much. Comments, objections?

I thought you had an as99127f to test?  I don't have one.  AFAIR there
are multiple different kinds out there.

I felt free to change/fix the conversions when going from as99127f to
independent asb100 driver because it required an updated sensors.conf 
for the user anyway.  as99127f is a different story - are you sure you
want to break everyone's existing config?

> BTW, MMH, would it make sense to move the as99127f support from w83781d
> to asb100? I haven't looked at the code in deep myself yet, just
> wondering if you have an opinion.

A step backward, I think.  If each driver supported just one chip then
that would allow the driver to stabilize and just accumulate bugfixes
until it's "done".

Someone submitted a patch once to put as99127f into its own driver.
I'm sorry I wasn't able to review it at the time.  Well, it's in the
archives...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
