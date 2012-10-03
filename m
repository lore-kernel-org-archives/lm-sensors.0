From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 03 Oct 2012 19:03:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing inclusions of <linux/err.h>
Message-Id: <CAKPcRGoDH3xqmQKK2-wu9UXX017VMedyHTT9Smyn86K0tPJn0w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121003131908.3a36fe3a@endymion.delvare>
In-Reply-To: <20121003131908.3a36fe3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 3, 2012 at 1:37 PM, Jean Delvare <khali@linux-fr.org> wrote:
> These drivers use IS_ERR so they should include <linux/err.h>.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: Luca Tettamanti <kronos.it@gmail.com>

Acked-by: Luca Tettamanti <kronos.it@gmail.com>

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
