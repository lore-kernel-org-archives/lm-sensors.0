From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Sep 2013 23:13:50 +0000
Subject: Re: [lm-sensors] Tmp75 sensor installation
Message-Id: <20130926231350.GA12366@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
In-Reply-To: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 26, 2013 at 04:24:24PM -0400, Benjo Dans wrote:
> Guenter/Jean,
> 
> Does lm-sensors support the Intel Ibex Peak-M (QM57) Chip?  I don't see it in the list.  Thank you.
> 
Looking it up on the web, its SMBus controller PCI ID is 0x3b30,
which is supported as "5/3400 Series (PCH)".

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
