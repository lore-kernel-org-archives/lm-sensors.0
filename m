From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 26 Jun 2011 20:26:48 +0000
Subject: Re: [lm-sensors] [v3] Add support for the Philips SA56004
Message-Id: <20110626202648.GA9118@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
In-Reply-To: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sdevrien@cisco.com
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Jun 06, 2011 at 10:40:45AM -0000, sdevrien@cisco.com wrote:
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
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
I don't see a reason for holding this patch up further. Applied to -next.
If you disagree, please speak up now or be silent forever.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
