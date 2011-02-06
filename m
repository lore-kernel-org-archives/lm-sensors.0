From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Feb 2011 16:28:22 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110206162822.GC30271@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 06, 2011 at 08:37:48AM -0500, Ian Dobson wrote:
[ ... ]
> 
> Looking in the n6776f specification if looks as if AUXTIN(temp3) and in6 
> share the same pin (pin 109) so we can't have both enabled.
> 
So they got rid of that for the nct6775f and w83667-b but reintroduced it
for nct6776f. Oh well. Would have been too simple otherwise.

Added complexity is that the sources for all temperature registers are now
selectable, but the status registers are still hardcoded.
Going to be fun to sort that out. Looks like I'll have to think about that 
a bit more.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
