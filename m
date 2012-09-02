From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Sep 2012 14:51:01 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add Maxim MAX197 support
Message-Id: <20120902145101.GA8306@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346377377-24717-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <20120831160439.GA5756@roeck-us.net>
 <5041D5DF.7060402@metafoo.de>
In-Reply-To: <5041D5DF.7060402@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

On Sat, Sep 01, 2012 at 11:31:11AM +0200, Lars-Peter Clausen wrote:
> On 08/31/2012 06:04 PM, Guenter Roeck wrote:
> > On Thu, Aug 30, 2012 at 09:42:57PM -0400, Vivien Didelot wrote:
> >> The MAX197 is an A/D converter, made by Maxim. This driver currently
> >> supports the MAX197, and MAX199. They are both 8-Channel, Multi-Range,
> >> 5V, 12-Bit DAS with 8+4 Bus Interface and Fault Protection.
> >>
> >> The available ranges for the MAX197 are {0,-5V} to 5V, and {0,-10V} to
> >> 10V, while they are {0,-2V} to 2V, and {0,-4V} to 4V on the MAX199.
> >>
> >> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> > 
> > Applied to -next.
> > 
> 
> Hm, now it's probably to late, but for this kind of general purpose ADC the IIO
> framework is in my opinion the better place to add support for it.
> 
Possibly. If someone writes an iio driver for it, and everyone agrees,
we can drop it from hwmon at that time.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
