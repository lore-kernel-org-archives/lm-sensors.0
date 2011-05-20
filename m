From: Wim Van Sebroeck <wim@iguana.be>
Date: Fri, 20 May 2011 11:48:39 +0000
Subject: Re: [lm-sensors] [PATCH v9 1/2] Use "request_muxed_region" in it87
Message-Id: <20110520114839.GS17887@infomag.iguana.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304745564-13003-1-git-send-email-natg@google.com> <1304745647-13051-1-git-send-email-natg@google.com>
In-Reply-To: <1304745647-13051-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, mikew@google.com

Hi Nat,

> 01 - Changes to it87 watchdog driver to use "request_muxed_region"
> Serialize access to the hardware by using "request_muxed_region" macro defined
> by Alan Cox. Call to this macro will hold off the requestor if the resource is
> currently busy. 
> 
> The use of the above macro makes it possible to get rid of
> spinlocks in it8712f_wdt.c and it87_wdt.c watchdog drivers.
> This also greatly simplifies the implementation of it87_wdt.c driver.
> 
>  "superio_enter" will return an error if call to "request_muxed_region" fails. 
> Rest of the code change is to ripple an error return from superio_enter to
> the top level.
> 
> Signed-off-by: Nat Gurumoorthy <natg@google.com>

Added to linux-2.6-watchdog-next.

Kind regards,
Wim.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
