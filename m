From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Nov 2010 21:59:22 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (it87) Fix manual fan speed
Message-Id: <1291067962.20815.162.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101129224211.067b0a7c@endymion.delvare>
In-Reply-To: <20101129224211.067b0a7c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2010-11-29 at 16:42 -0500, Jean Delvare wrote:
> The manual fan speed control logic of the IT8721F is much different
> from what older devices had. Update the code to properly support that.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
