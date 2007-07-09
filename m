From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 09 Jul 2007 15:52:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon/lm85: Use dynamic sysfs callbacks
Message-Id: <20070709175236.238e7ada.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070705203612.7e630af2@hyperion.delvare>
In-Reply-To: <20070705203612.7e630af2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Jul 2007 20:36:12 +0200
Jean Delvare <khali@linux-fr.org> wrote:

>  drivers/hwmon/lm85.c |  551 ++++++++++++++++++++++----------------------------
>  1 file changed, 244 insertions(+), 307 deletions(-)
> 

I reviewed this patch and I don't see anything wrong. It is repetitive change of
API for set/show functions.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
