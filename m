From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Dec 2013 08:02:32 +0000
Subject: Re: [lm-sensors] [PATCH 10/39] hwmon: remove DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <20131203090232.7ba0e002@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
	<001f01ceefb3$b1968820$14c39860$%han@samsung.com>
	<20131203001741.GA18237@roeck-us.net>
In-Reply-To: <20131203001741.GA18237@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, 2 Dec 2013 16:17:41 -0800, Guenter Roeck wrote:
> On Tue, Dec 03, 2013 at 08:10:29AM +0900, Jingoo Han wrote:
> > Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> > is not preferred.
> > 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Jean Delvare <khali@linux-fr.org>

too. I never liked this macro and I'm very happy to see it go.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
