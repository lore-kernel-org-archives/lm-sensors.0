From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 08 Oct 2010 11:00:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: I2C addresses are constant
Message-Id: <20101008110051.GA24539@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101008120354.16f27752@endymion.delvare>
In-Reply-To: <20101008120354.16f27752@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 08, 2010 at 06:03:54AM -0400, Jean Delvare wrote:
> We can mark normal_i2c const. Almost all drivers do that already, so
> fix the 3 remaining ones before they are used as (bad) examples for
> new drivers.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: George Joseph <george.joseph@fairview5.com>

Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
