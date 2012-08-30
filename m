From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 30 Aug 2012 21:14:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add Maxim MAX197 support
Message-Id: <20120830211444.GA11181@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120830201019.GA3875@roeck-us.net>
 <1040994502.402858.1346361031972.JavaMail.root@mail.savoirfairelinux.com>
In-Reply-To: <1040994502.402858.1346361031972.JavaMail.root@mail.savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

On Thu, Aug 30, 2012 at 05:10:32PM -0400, Vivien Didelot wrote:
> Hi Guenter,
> 
> Thanks for your detailed comments. I'll send a new version soon.
> 
> About the following comment, I agree with you. However as there is no convention for this case, for now I would prefer to stick with the model as seen in drivers such as sht15.
> 
Actually, there is a convention, and it is much cleaner than using
multiple platform driver instances. I sent you a separate e-mail a
minute ago, describing how it works.

We should actually fix the sht15 driver as well to use the same approach.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
