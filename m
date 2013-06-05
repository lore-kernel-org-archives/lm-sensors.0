From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Jun 2013 09:02:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: mc13783-adc: Refactor source to indicate various mc13xxx chips
Message-Id: <20130605110206.02fc09f3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed,  5 Jun 2013 12:57:07 +0400, Alexander Shiyan wrote:
> This patch renames structures, variables and functions to indicate support
> for various MC13xxx chips.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/hwmon/mc13783-adc.c | 135 +++++++++++++++++++++-----------------------
>  1 file changed, 63 insertions(+), 72 deletions(-)

Nack. This change serves absolutely no purpose, all it's doing it make
everyone's life harder. Just don't do that, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
