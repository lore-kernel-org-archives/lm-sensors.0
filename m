From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030926213556.GB18399@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 25, 2003 at 11:32:38PM +0200, Jean Delvare wrote:

<snip>

Thanks for the good summary.

> So, as you can see, most drivers would need to be changed. However, the
> policy I propose is only the way I see the things, but some people here
> are much more experienced with evil monitoring chips than I am myself.
> Although chip initialization has proven to cause problems, I guess it
> may be even worse without it in some cases. I may provide a patch
> against 2.6.0-test5 that converts initialization routines as described
> above, but I just can't promise the conversions are what we all want.
> 
> One possible compromise would be to provide an init parameter for all
> module, ranging from 0 to N, where N is 3 (but could depend on the
> module after all). 0 wouldn't initialize anything. 1 would initialize
> the configuration registers. 2 would be 1 plus initialize limits to
> default value. 3 would reset the chip plus 1 and 2. Or we may decide
> that init is a bit vector, where 1<<0 resets the chip, 1<<1 sets the
> limits, 1<<2 sets the configuration, (order to be defined) and so on.
> I'd like to hear opinions about that. My purpose here is to provide a
> standard way for the user to force a given init if the default (which
> would probably depend on the driver) doesn't for for him/her. This would
> make me feel more comfortable with changing the default initialization.

0, 1, 2, and 3 sound good to me.  Anyone else have an opinion?

thanks,

greg k-h
