From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 30 Jan 2011 00:19:22 +0000
Subject: Re: [lm-sensors] [PATCH] max6639.c: Set reasonable default PWM
Message-Id: <20110130001922.GA30180@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1296317041-28718-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1296317041-28718-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 29, 2011 at 11:04:01AM -0500, stigge@antcom.de wrote:
> max6639.c: Set reasonable default PWM frequency
> 
> This patch initializes register CONFIG3 to a reasonable default PWM frequency
> of 25kHz, to prevent audible sound in fan.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
Applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
