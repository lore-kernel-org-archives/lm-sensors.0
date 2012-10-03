From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Oct 2012 15:11:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing inclusions of <linux/jiffies.h>
Message-Id: <20121003151131.GA19625@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121003131908.3a36fe3a@endymion.delvare>
In-Reply-To: <20121003131908.3a36fe3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 03, 2012 at 01:19:08PM +0200, Jean Delvare wrote:
> Many hwmon drivers use jiffies but omit the inclusion of the header
> file. Fix that, and also fix one driver which was including the header
> file but didn't need it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Luca Tettamanti <kronos.it@gmail.com>
> Cc: Marc Hulsman <m.hulsman@tudelft.nl>
> Cc: Rudolf Marek <r.marek@assembler.cz>

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
