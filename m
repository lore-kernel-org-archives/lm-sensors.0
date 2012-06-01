From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 01 Jun 2012 15:25:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Message-Id: <20120601152504.GA25384@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
 <20120524205426.GW3074@spo001.leaseweb.com>
 <1338307894.478.68.camel@groeck-laptop>
 <4FC8C5B3.2060108@redhat.com>
 <20120601160657.3b93393c@endymion.delvare>
In-Reply-To: <20120601160657.3b93393c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Wim Van Sebroeck <wim@iguana.be>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Fri, Jun 01, 2012 at 10:06:57AM -0400, Jean Delvare wrote:
> On Fri, 01 Jun 2012 15:37:55 +0200, Hans de Goede wrote:
> > Now that we've a common watchdog core, I would also like to convert the
> > fschmd watchdog code to it (one of these days). Which raises the question
> > through which tree should that conversion go in. fschmd is primarily a hwmon
> > driver, but the changes will only touch the watchdog part...
> > 
> > I guess it would be best to get the conversion in to Wim's tree, even though
> > that slightly increases the chance of conflicts. The fschmd driver does not see
> > a lot of churn, and I think Wim is a better reviewer for watchdog related
> > patches :)
> 
> Chances of conflicts are so thin, I vote for getting it through Wim's
> watchdog tree.
>
Ok with me.

Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
