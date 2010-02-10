From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Feb 2010 14:44:04 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <20100210154404.45e8afd6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Feb 2010 15:42:44 +0200, D. Can Celasun wrote:
> Seems like I'll be waiting for an updated coretemp.
> 
> As for the kernel logs, couldn't see anything relevant but in case I'm
> missing something, kernel log is attached.

The kernel log doesn't seem to contain all the messages since last
boot. You should be able to regenerate the relevant messages by
unloading the i2c-i801 driver and loading it again.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
