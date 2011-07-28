From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 06:29:43 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (lm90) Refactor reading of
Message-Id: <20110728062943.GC22026@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110724203705.37ad14cf@endymion.delvare>
In-Reply-To: <20110724203705.37ad14cf@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 24, 2011 at 02:37:05PM -0400, Jean Delvare wrote:
> Several vendors implement a second configuration register, which we
> check during device detection. Refactor the code to avoid duplication.
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
