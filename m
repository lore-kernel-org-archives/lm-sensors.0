From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Sep 2008 20:23:56 +0000
Subject: Re: [lm-sensors] Add a driver for the ADT7475 thermal sensor
Message-Id: <20080929222356.39846d64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080926232036.GH22230@cosmic.amd.com>
In-Reply-To: <20080926232036.GH22230@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

On Mon, 29 Sep 2008 14:13:50 -0600, Jordan Crouse wrote:
> On 27/09/08 16:04 +0200, Hans de Goede wrote:
> > 1) As Andrew Morten already noted as comment to some other patch, its better to
> >     make complex macros like this one:
> > +#define TEMP2REG(val) ((val) <= -128000 ? -128 : \
> > +       (val) >= 127000 ? 127 : \
> > +       (val) < 0 ? ((val) - 500) / 1000 : \
> > +       ((val) + 500) / 1000)
> > 
> >     static functions rather then macros all the ? constructions will lead to
> >     interesting code and if you make it a function the compiler will usually
> >     create significant smaller code
> 
> I have turned all the macros into function.  Am I right in saying that
> the current kernel policy is to not mark them as inline and let
> the compiler decide?

I am happy to see inline keywords in the code. Different versions of
gcc have different levels of smartness when it comes to auto-inlining.
Some versions apparently have an algorithm as simple as "inline
everything that's used only once", which doesn't work at all for our
drivers. As long as you do not force the inlining of large functions,
there's really no drawback to using the inline keyword.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
