From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Aug 2013 16:21:27 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <20130830162127.GA5182@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 30, 2013 at 02:04:53PM +0200, Mercier Ivan wrote:
> Hi everybody,
> I have a ADT7481 sensor and I would like to make it work.
> What the current status of this driver?
> Does somebody start writting some code?
> How can I start?
> 
If you compare the datasheet with other temperature sensor datasheets, you'll
notice similarities with ADT7461 and MAX6696, both of which are supported by the
lm90 driver. You can start from there, look for similarities and differences,
add support for ADC7481 to the lm90 driver, and submit a patch to get it
integrated.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
