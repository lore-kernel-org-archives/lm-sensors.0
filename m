From: Greg Schnorr <gschnorr@cisco.com>
Date: Mon, 07 Mar 2011 21:44:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) More stringent checking of
Message-Id: <C99A91CB.5A89D%gschnorr@cisco.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1299043940-22798-1-git-send-email-guenter.roeck@ericsson.com>
References: <1299043940-22798-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299043940-22798-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Looks good, tested and works on one such VOUT_MODE poor design...

On 3/1/11 9:32 PM, "Guenter Roeck" <guenter.roeck@ericsson.com> wrote:

> Some PMBus chips do not support the VOUT_MODE register. To make matters worse,
> such chips may not return an error when reading the register either, but
> instead
> return 0xff.
> 
> Check if the register exists using pmbus_check_byte_register() before reading
> its value. In addition, validate the returned value and ignore it if it is
> 0xff
> (which is invalid).
> 
> Reported-by: Greg Schnorr <gschnorr@cisco.com>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Greg Schnorr <gschnorr@cisco.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
