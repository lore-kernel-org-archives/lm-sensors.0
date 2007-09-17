From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2007 14:00:04 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070917160004.6f45fff2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Mon, 17 Sep 2007 14:28:17 +0200, Krzysztof Helt wrote:
> On Mon, 17 Sep 2007 13:25:53 +0200 Jean Delvare wrote:
> > Krzysztof, can you please send me (in private) a dump of your chip (as
> > returned by i2cdump)? I'd like to add it to my collection so that I can
> > emulate this chip with i2c-stub.
>
> Give me commands to do this (i2cdump something). Chips are located at 0x2d and 0x2e.

# modprobe i2c-dev
# i2cdetect -l
(find out which i2c bus corresponds to the motherboard SMBus)
# i2cdetect <N>
(where <N> is the bus number in question; this should show chips at 0x2d
 0x2e)
# i2cdump <N> 0x2d b > thmc50-2d.dump
# i2cdump <N> 0x2e b > thmc50-2e.dump

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
