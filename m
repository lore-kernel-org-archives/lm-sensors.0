From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Feb 2011 07:33:52 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207083352.573cc27d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Feb 2011 20:50:05 -0800, Guenter Roeck wrote:
> On Sun, Feb 06, 2011 at 10:50:02PM -0500, Andy Lutomirski wrote:
> > On 02/05/2011 12:58 PM, Guenter Roeck wrote:
> > > Hi,
> > >
> > > a standalone driver for W83667HG-I (NCT6771F, NCT6775F) and NCT6776F
> > > is available for testing at http://roeck-us.net/linux/drivers/w83627ehf/.
> > >
> > > Please test and let me know if there are any problems.
> > 
> > It appears to mostly work on an Intel DH67GD (nct6775).  There are two 
> > issues:
> > 
> > 1. The first time I ran 'sensors', my CPU fan showed 0 RPM instead of 
> > the correct value (~134).  Running it again shows the correct value.
> > 
> If you check the log, you might see a notice that the fan divisors were modified.
> Can you check ?

Note: if you set a proper fan_min value in your configuration file,
"sensors -s" will set the right divisor directly so the first "sensors" will
work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
