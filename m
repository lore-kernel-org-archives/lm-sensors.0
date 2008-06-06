From: Pau Oliva Fora <pau@eslack.org>
Date: Fri, 06 Jun 2008 15:37:33 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <484959BD.6050407@eslack.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080606102636.ZZRA012@mailhub.coreip.homeip.net> <484950D2.9070809@tremplin-utc.net>
In-Reply-To: <484950D2.9070809@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

Eric Piel wrote:
>> I would recommend converting the input piece to input_polled_device
>> instead of managing the polling thread by yourselves.
> Yes, you are right, I had forgotten about this one! That said, for now 
> I'm working on removing the polling and relying only the interrupts. So 
> if it works that shouldn't be needed :-)
> 

I think going to interrupt-only approach will cause a problem in the HTC 
Shift:

In CTRL_REG2 (21h) if you set to 1 the Interrupt ENable (IEN) field the 
device shuts down.

I guess HTC took the "polling" approach in the windows driver, and they 
enable the interrupt when the sensor reports a "free fall" event, to 
have the disk parked and protect the hardware from being damaged.

Maybe you can keep the input_polled_device together with interrupts and 
select one or the other depending on DMI information (same as for 
swaping the axis, etc.)

Cheers,

	Pau Oliva

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
