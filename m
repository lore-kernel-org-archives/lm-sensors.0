From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 May 2011 13:50:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc6w201) Properly handle all
Message-Id: <20110527135030.GA2693@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110527135858.2c5a904e@endymion.delvare>
In-Reply-To: <20110527135858.2c5a904e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 27, 2011 at 07:58:58AM -0400, Jean Delvare wrote:
> Handle errors on 8-bit register reads and writes too. Also use likely
> and unlikely to make the functions faster on success.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
