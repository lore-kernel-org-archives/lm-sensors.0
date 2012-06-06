From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Jun 2012 04:04:23 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <20120606040423.GA19202@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 05, 2012 at 11:20:05PM -0400, R, Durgadoss wrote:
> Hi Guenter/Jean,
> 
> > 
> > On Tue, 5 Jun 2012 11:19:15 -0700, Guenter Roeck wrote:
> > > Do you have access to the Medfield Atom (Z2640) specification ? I did
> > > not find anything on the Intel web site. It would be interesting to know
> > > its TjMax. Same for the CE4100 - Intel seems to closely guard those
> > > specifications.
> > 
> > I don't. Durga or Fenghua maybe?
> 
> I don't have any public specification as such. I use the same platform for testing.
> There it says TjMax is 90 (which corresponds to cpu model 0x27).
> This is the patch that Jean has submitted a couple of days ago.
> 
Hi Durga,

sorry, you lost me. What do you mean with "there" ? If it is what coretemp reports,
it is just a wild guess, unless you or Jean know better from some document.

> Guenter, Could you please give me website link where you are getting details on
> TjMax for other platforms ? I will try and see if I can make people add the
> 'Atom platform' details also there.
> 

Usually it is in the device datasheet / specification or the device thermal guide
if it exists. I don't think there is a single web site with all the information,
or at least I don't know one. Problem is that no such documentation seems to exist,
at least not in public, for the Z2460 (or CE4100, for that matter). Only reason
for mentioning CE4100 is that someone suggested a patch for it a couple of years ago,
but it went nowhere, presumably since tjmax (supposedly 110 C) was never confirmed,
nor are there well defined means to detect it.

> BTW, my Medfield platform's /proc/cpuinfo says model as Z2460 whereas you
> are saying Z2640. Is it a typo or actually reported as Z2640 somewhere ?
> 
Typo, sorry.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
