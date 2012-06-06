From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 06 Jun 2012 03:20:05 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB59130D56@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter/Jean,

> 
> On Tue, 5 Jun 2012 11:19:15 -0700, Guenter Roeck wrote:
> > Do you have access to the Medfield Atom (Z2640) specification ? I did
> > not find anything on the Intel web site. It would be interesting to know
> > its TjMax. Same for the CE4100 - Intel seems to closely guard those
> > specifications.
> 
> I don't. Durga or Fenghua maybe?

I don't have any public specification as such. I use the same platform for testing.
There it says TjMax is 90 (which corresponds to cpu model 0x27).
This is the patch that Jean has submitted a couple of days ago.

Guenter, Could you please give me website link where you are getting details on
TjMax for other platforms ? I will try and see if I can make people add the
'Atom platform' details also there.

BTW, my Medfield platform's /proc/cpuinfo says model as Z2460 whereas you
are saying Z2640. Is it a typo or actually reported as Z2640 somewhere ?

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
