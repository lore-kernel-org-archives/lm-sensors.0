From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 06 Jun 2012 04:15:52 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB59130DF1@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

[snip.]
> > I don't have any public specification as such. I use the same platform for testing.
> > There it says TjMax is 90 (which corresponds to cpu model 0x27).
> > This is the patch that Jean has submitted a couple of days ago.
> >
> Hi Durga,
> 
> sorry, you lost me. What do you mean with "there" ? If it is what coretemp
> reports,
> it is just a wild guess, unless you or Jean know better from some document.

It is what coretemp reports.
I know it is 90C, from an internal document, though :-(
That's why was asking is there a place where I can ask folks to update.

> 
> > Guenter, Could you please give me website link where you are getting details
> on
> > TjMax for other platforms ? I will try and see if I can make people add the
> > 'Atom platform' details also there.
> >
> 
> Usually it is in the device datasheet / specification or the device thermal guide
> if it exists. I don't think there is a single web site with all the information,
> or at least I don't know one. Problem is that no such documentation seems to
> exist,
> at least not in public, for the Z2460 (or CE4100, for that matter). Only reason
> for mentioning CE4100 is that someone suggested a patch for it a couple of years
> ago,
> but it went nowhere, presumably since tjmax (supposedly 110 C) was never
> confirmed,
> nor are there well defined means to detect it.
> 

I will see if I can talk to people to see what can be done better here.
I will try & try & try.. :-)

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
