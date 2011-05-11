From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 13:40:14 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon/sch5627: Trigger Vbat
Message-Id: <20110511154014.6f1cc065@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110504174240.1491e1d4@endymion.delvare>
In-Reply-To: <20110504174240.1491e1d4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2011 14:31:41 +0200, Hans de Goede wrote:
> The sch5627 needs to be explicitly told to start an adc conversion
> for Vbat, once in a while. Without this Vbat may read 0, and will never
> get updated.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/sch5627.c |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
