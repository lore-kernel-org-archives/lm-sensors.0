From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: [PATCH 2.6] I2C sysfs interface documentation
Message-Id: <3FB83772.64EFDA58@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116203250.4bce6b7e.khali@linux-fr.org>
In-Reply-To: <20031116203250.4bce6b7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If you do want to go all the way, IPMI supports 8 limits per sensor.
Critical, non-critical, non-recoverable, and hysteresis, each for both
high and low.

I suppose IPMI is a good guideline for the ultimate in possibilities,
should you wish to refer to it in the sysfs design.
Although I think a sophisticated BMC manager would access the BMC
directly rather than through /proc or /sys.
So don't be overly concerned with /sys limiting the IPMI information.

What I do in bmcsensors is pick the best two of those 8 and present them
to the user.

IPMI defines hysteresis as a delta from the limit. I subtract one
from the other and present that through /proc as absolute values.
I think we should continue to do that
(i.e. I agree with Mark Hoffman).



Jean Delvare wrote:
> 
> > current is in there because the IPMI spec includes current sensors
> > so I added support to bmcsensors.
> > Never had a report of a BMC that actually measures current, though...
> 
> Took a look at that document, it specifies hysteresis values for all
> sensor types. It even specifies two values (one for negative-going
> thresholds, one for positive-going thresholds).
> 
> BMC isn't in 2.6 yet anyway, so we can safely remove references to
> current hysteresis for now.
> 
> That quick look at the IPMI specification once again raised the question
> of what file naming convention to choose for storing hysteresis values
> in sysfs. The fact that IPMI provides space for two hysteresis values
> per sensor proves that names like "temp_hyst1" (as I did in the patch I
> just sent to Greg) won't be sufficent to handle all cases. I'm still in
> favor of storing hysteresis as a values linked to another limit, and not
> as a limit per se. That is, temp_max1 and temp_max1_hyst (or
> temp_max_hyst1, or even temp_hyst_max1, whatever fits better with the
> current logic). Following Mark Hoffman's views, value in these files
> would be an absolute temperature, regardless of how the chipset actually
> handles it.
> 
> I would like everyone to comment on that if needed. If we can agree on a
> clean, logic naming convention, I volunteer to update the documentation
> accordingly and modify existing drivers.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
