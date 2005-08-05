From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 05 Aug 2005 21:30:41 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <1123270204.28387.17.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the input, Rudolf.  I'm going through the doc file now,
editing it to eliminate your concerns here.  I'll probably push it out
with the rest of the lm93 patch if/when there are updates to the code
that need to go out as well, or sooner if it looks like the code is
good.

On Fri, 2005-08-05 at 05:45, Rudolf Marek wrote:
> > +    Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
> We like the html page with all the stuff more.

Substituted with: http://www.national.com/pf/LM/LM93.html

> > +LM93 Unique sysfs Files
> > +-----------------------
> Please look to other files how is this section done. (like in my w8792d patch recently)
> http://www.google.com/url?sa=t&ct=res&cd=1&url=http%3A//lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012391.html&ei=WVDzQrHNPL_WRPnspMQC

The URL is incorrect, but I managed to find your patch anyway.  I've
rewritten this whole section to try and conform to your example.

> > +Sample Configuration File
> > +-------------------------
> > +
> > +Here is a sample LM93 chip config for sensors.conf:
> > +
> 
> DO we have it in lm_sensors package?

If you mean in the /etc/sensors.conf.eg file in the lm_sensors
distribution, it looks like the answer is "no."

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

