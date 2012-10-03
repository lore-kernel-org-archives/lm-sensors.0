From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 03 Oct 2012 19:02:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing inclusions of <linux/jiffies.h>
Message-Id: <CAKPcRGrvC-dks1Qyx=d-kwdVxvE3rJQB=tvxuO_e6QECpjZEwA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121003131908.3a36fe3a@endymion.delvare>
In-Reply-To: <20121003131908.3a36fe3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 3, 2012 at 1:19 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Many hwmon drivers use jiffies but omit the inclusion of the header
> file. Fix that, and also fix one driver which was including the header
> file but didn't need it.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Luca Tettamanti <kronos.it@gmail.com>

Acked-by: Luca Tettamanti <kronos.it@gmail.com>

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
