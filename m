From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 18 Jun 2009 08:52:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) DMI probing for AB9,
Message-Id: <20090618105230.71df0a5d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200906172258.57072.alistair@devzero.co.uk>
In-Reply-To: <200906172258.57072.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 17 Jun 2009 22:55:16 +0100, Alistair John Strachan wrote:
> Switch the AB9, AB9 QuadQT and IX38 QuadGT over from port
> probing to the preferred DMI probe method.
> 
> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> Tested-by: dan <dan@deeog.com>
> Tested-by: Nygel Lyndley <nygel.lyndley@gmail.com>
> Tested-by: Dmitriy Fedchenko <dmitriy-fedc@yandex.ru>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/abituguru3.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
