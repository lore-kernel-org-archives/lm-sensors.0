From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 06 Jun 2011 12:40:47 +0000
Subject: Re: [lm-sensors] [PATCH v3] Add support for the Philips SA56004
Message-Id: <20110606124047.GA26180@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
In-Reply-To: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sdevrien@cisco.com" <sdevrien@cisco.com>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 06, 2011 at 06:40:45AM -0400, sdevrien@cisco.com wrote:
> From: Stijn Devriendt <sdevrien@cisco.com>
> 
> Add support for the Philips SA56004, an LM86
> compatible temperature sensor.
> 
> Changes since v2:
> - Changed BUG_ON to WARN_ON
> Changes since v1:
> - Updated documentation
> - Trace replaced by BUG_ON
> - style updates
> 
> Signed-off-by: Stijn Devriendt <sdevrien@cisco.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Jean, do you want to take this and/or have a look, or should I ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
