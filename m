From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Oct 2010 12:40:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (pcf8591) Register as a hwmon
Message-Id: <20101005124029.GA8257@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101005133103.772a1d3a@endymion.delvare>
In-Reply-To: <20101005133103.772a1d3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 05, 2010 at 07:31:03AM -0400, Jean Delvare wrote:
> Register PCF8591 devices as hwmon devices. There's little point in
> implementing the standard sysfs interface if we don't register it in
> a way libsensors will pick it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
