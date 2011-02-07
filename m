From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 16:03:04 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207160304.GB1770@ericsson.com>
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
Unless I am missing something, there does not seem to be a register to select AUXTIN
vs. VIN3. Only way to detect if pin109 is used for AUXTIN or VIN3 seems to be to check
if AUXTIN is selected as any of the temperature sources, and disable VIN3 (in6)
if it is.

Do you see a better way ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
