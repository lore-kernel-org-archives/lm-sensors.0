From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Oct 2010 12:41:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pcf8591) Don't attempt to
Message-Id: <20101005124123.GB8257@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101005133138.489ed684@endymion.delvare>
In-Reply-To: <20101005133138.489ed684@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 05, 2010 at 07:31:38AM -0400, Jean Delvare wrote:
> The PCF8591 can't be detected, don't even try. There are plenty of
> other means to instantiate i2c devices these days.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
