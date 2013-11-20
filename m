From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Nov 2013 16:32:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] ACPI/hwmon: Fix acpi_bus_get_device() return value check
Message-Id: <20131120163219.GC28683@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384939706-6292-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1384939706-6292-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 20, 2013 at 05:28:23PM +0800, Yijing Wang wrote:
> Since acpi_bus_get_device() returns plain int and not acpi_status,
> ACPI_FAILURE() should not be used for checking its return value.  Fix that.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: lm-sensors@lm-sensors.org

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
