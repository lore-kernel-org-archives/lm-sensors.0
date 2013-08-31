From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Aug 2013 12:56:33 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <20130831145633.0b316d65@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 30 Aug 2013 09:21:27 -0700, Guenter Roeck wrote:
> On Fri, Aug 30, 2013 at 02:04:53PM +0200, Mercier Ivan wrote:
> > Hi everybody,
> > I have a ADT7481 sensor and I would like to make it work.
> > What the current status of this driver?
> > Does somebody start writting some code?
> > How can I start?
> > 
> If you compare the datasheet with other temperature sensor datasheets, you'll
> notice similarities with ADT7461 and MAX6696, both of which are supported by the
> lm90 driver. You can start from there, look for similarities and differences,
> add support for ADT7481 to the lm90 driver, and submit a patch to get it
> integrated.

For reference, lm90 vs. new driver was already discussed here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025132.html

Back then, Malcolm Crossley (Cc'd) was working on adding support for
the ADT7481. It was four years ago, I have no idea if it actually
happened or not. Malcolm, do you have code you would like to share with
Ivan?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
