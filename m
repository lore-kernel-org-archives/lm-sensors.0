From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 06:27:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Make SA56004 detection more
Message-Id: <20110728062732.GB22026@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110724203615.04e42d86@endymion.delvare>
In-Reply-To: <20110724203615.04e42d86@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 24, 2011 at 02:36:15PM -0400, Jean Delvare wrote:
> With a device ID register value of 0, the SA56004 detection is rather
> weak. Check several other register too to confirm the detection, as we
> do for other supported devices.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Stijn Devriendt <sdevrien@cisco.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
