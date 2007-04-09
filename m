From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 09 Apr 2007 20:04:32 +0000
Subject: Re: [lm-sensors] [PATCH] Apple SMC driver - fix input device
Message-Id: <20070409130432.f4902155.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F7C083.7090504@boichat.ch>
	<45FE1D44.8000805@boichat.ch>
	<200703221137.35906.dtor@insightbb.com>
	<461A455C.9040508@boichat.ch>
In-Reply-To: <461A455C.9040508@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rlove@rlove.org, linux-kernel@hansmi.ch, Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, 09 Apr 2007 21:53:32 +0800
Nicolas Boichat <nicolas@boichat.ch> wrote:

> Fixed all these. Thanks.
> 
> Andrew, could you please push this patch in mm too?
> 
> Best regards,
> 
> Nicolas
> 
> - Invert y axis on input device.
> - Only activate the input device polling timer when the device is open.
> - Others minor fixes asked by Dmitry Torokhov.
> 
> Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>

Thanks.

I've been assuming that this patch will go via Jean, since it is in
drivers/hwmon/applesmc.c.  But perhaps that is inappropriate, and it is
more a Paul or Dmitry thing.  Or a me thing.

Who wants to take it??

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
