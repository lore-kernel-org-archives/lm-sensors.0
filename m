From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 06 Jun 2008 15:11:08 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <20080606111051.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080606102636.ZZRA012@mailhub.coreip.homeip.net> <484950D2.9070809@tremplin-utc.net>
In-Reply-To: <484950D2.9070809@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

On Fri, Jun 06, 2008 at 04:59:30PM +0200, Eric Piel wrote:
> Dmitry Torokhov wrote:
>> Hi,
> Hello,
>>
>>
>> I would recommend converting the input piece to input_polled_device
>> instead of managing the polling thread by yourselves.
> Yes, you are right, I had forgotten about this one! That said, for now I'm 
> working on removing the polling and relying only the interrupts. So if it 
> works that shouldn't be needed :-)
>

Oh, great, this is even better.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
