From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 03 Dec 2013 02:42:30 +0000
Subject: Re: [lm-sensors] [PATCH 10/39] hwmon: remove DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <529D4516.3020201@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com> <001f01ceefb3$b1968820$14c39860$%han@samsung.com>
In-Reply-To: <001f01ceefb3$b1968820$14c39860$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 'Jean Delvare' <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On 12/02/2013 03:10 PM, Jingoo Han wrote:
> Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> is not preferred.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to hwmon-next

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
