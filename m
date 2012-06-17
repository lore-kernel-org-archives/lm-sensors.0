From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 19:46:55 +0000
Subject: Re: [lm-sensors] [PATCH 90/95] hwmon: (k8temp) Convert to use devm_ functions
Message-Id: <20120617214655.6ed8c249@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-91-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-91-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:11 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/k8temp.c |   25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
