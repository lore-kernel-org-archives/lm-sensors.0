From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 18:40:03 +0000
Subject: Re: [lm-sensors] [PATCH] thmc50: individual alarm and fault files
Message-Id: <20070812204003.7ca743de@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46b4696f8c716@wp.pl>
In-Reply-To: <46b4696f8c716@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sat, 04 Aug 2007 13:56:31 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds individual alarm and fault files to
> the thmc50 driver. These sysfs entries are required
> for a new libsensors library.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thank for working on this. Your patch works, but it's not very
efficient. You could pass the bit shift value directly in index for
each alarm and fault file, rather than computing it again each time.
Then you could have a single callback for alarms and faults. Please see
the lm90 driver for an example of this implementation.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
