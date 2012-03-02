From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Mar 2012 21:38:09 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enab
Message-Id: <1330724289.23014.321.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-4-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-4-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2012-03-02 at 16:26 -0500, Nikolaus Schulz wrote:
> On Fri, Mar 02, 2012 at 12:02:44PM -0800, Guenter Roeck wrote:
> > On Fri, 2012-03-02 at 14:47 -0500, Nikolaus Schulz wrote:
> > > > That is why I suggested to split the patch into two parts. I don't mind
> > > > a fix for pwm_mode=3, limiting its scope. My concern is that pwm_mode=4
> > > > adds functionality which I would prefer to delay until 3.4.
> > > 
> > > Well, as I have said, this functionality may already be activated by the
> > > BIOS.  The driver has to deal with it, right?  It's not so much a matter
> > > of supporting something, but a matter of not messing it up.
> > > 
> > Hmm - good point. I'll accept that. I'll add your reasoning to the patch
> > description and apply it to 3.3.
> 
> Thank you.  And yes, adding an explicit note about that to the commit
> message is a good idea.  I should have been more clear there.
> 
> Sorry for bugging you some more, do you consider
> 331255d35d6f517020485aee38dbb8b8dfaa1642 "hwmon: (f75375s) Fix writes to
> the pwm* attribute for the F75387" for v3.3?  I think it should go in.
> 
Yes.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
