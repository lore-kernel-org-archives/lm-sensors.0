From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Mon, 24 Apr 2006 06:30:12 +0000
Subject: [lm-sensors] [2.6 patch] drivers/w1/: possible cleanups
Message-Id: <20060424063011.GA17636@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060423213829.GH13666@stusta.de>
In-Reply-To: <20060423213829.GH13666@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 23, 2006 at 11:38:29PM +0200, Adrian Bunk (bunk at stusta.de) wrote:
> This patch contains the following possible cleanups:
> - the following file did't #include the header with the prototypes for
>   it's global functions:
>   - w1_int.c
> - #if 0 the following unused global function:
>   - w1_family.c: w1_family_get()
> - make the following needlessly global functions static:
>   - w1_family.c: __w1_family_put()
>   - w1_io.c: w1_delay()
>   - w1_io.c: w1_touch_bit()
>   - w1_io.c: w1_read_8()
> - remove the following unused EXPORT_SYMBOL's:
>   - w1_family.c: w1_family_put
>   - w1_family.c: w1_family_registered
> 
> Signed-off-by: Adrian Bunk <bunk at stusta.de>

ACK.

Thank you, Adrian.

-- 
	Evgeniy Polyakov

