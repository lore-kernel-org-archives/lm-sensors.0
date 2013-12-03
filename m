From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 03 Dec 2013 00:17:41 +0000
Subject: Re: [lm-sensors] [PATCH 10/39] hwmon: remove DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <20131203001741.GA18237@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
 <001f01ceefb3$b1968820$14c39860$%han@samsung.com>
In-Reply-To: <001f01ceefb3$b1968820$14c39860$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 'Jean Delvare' <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Tue, Dec 03, 2013 at 08:10:29AM +0900, Jingoo Han wrote:
> Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> is not preferred.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
