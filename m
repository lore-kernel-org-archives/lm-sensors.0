From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Mon, 09 Apr 2007 15:17:42 +0000
Subject: Re: [lm-sensors] [PATCH] Apple SMC driver - fix input device
Message-Id: <d120d5000704090817q16686abcu1d49b480a07eeca0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F7C083.7090504@boichat.ch> <45FE1D44.8000805@boichat.ch>
	 <200703221137.35906.dtor@insightbb.com> <461A455C.9040508@boichat.ch>
In-Reply-To: <461A455C.9040508@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rlove@rlove.org, linux-kernel@hansmi.ch

Hi Nicolas,

On 4/9/07, Nicolas Boichat <nicolas@boichat.ch> wrote:
> Hi Dmitry,
>
> Sorry I did not receive your message originally, someone else pointed it
> to me recently, and I recovered it from LKML archives.
>

For some reason your server does not like @insightbb.com addresses.

>
> - Invert y axis on input device.
> - Only activate the input device polling timer when the device is open.
> - Others minor fixes asked by Dmitry Torokhov.
>
> Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>
>

You may add:

 Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
