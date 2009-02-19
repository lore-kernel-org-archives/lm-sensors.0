From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Feb 2009 16:56:59 +0000
Subject: Re: [lm-sensors] Gigabyte GA-EX58-UD4P
Message-Id: <20090219175659.72248ce1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499C23E8.1040507@gmail.com>
In-Reply-To: <499C23E8.1040507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Wed, 18 Feb 2009 07:06:16 -0800, Dean Loros wrote:
> I've posted to the list about my new motherboard--it's using the Chip 
> `ITE IT8720 Super IO Sensors' and the new sensors detect script notes 
> that it is not supported yet.

Does it? The ITE IT8720 _is_ supported in (upcoming) kernel 2.6.29. On
previous kernels you can use the force_id parameter of the it87 driver
to get temporary support, too.

> What can I do to help get it moved along? 
> Please send me any informations/thoughts you have about this.

I'll read what you've posted to the list and will answer when I find
some time.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
