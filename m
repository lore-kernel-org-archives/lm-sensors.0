From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 Jan 2012 03:18:33 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm63) Make fan speed control strategy changeable
Message-Id: <20120127031833.GB27607@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120126215436.515a0e67@endymion.delvare>
In-Reply-To: <20120126215436.515a0e67@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 26, 2012 at 03:54:36PM -0500, Jean Delvare wrote:
> Let the user switch between automatic and manual fan speed control.
> Before switching to automatic fan speed control, we always check that
> the lookup table looks sane.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
