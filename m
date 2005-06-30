From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 30 Jun 2005 20:51:28 +0000
Subject: [lm-sensors] Re: [RESEND][PATCH] fix w1 for big-endian
Message-Id: <20050630225101.4f4290b7@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050630154751.82729.qmail@web53501.mail.yahoo.com>
In-Reply-To: <20050630154751.82729.qmail@web53501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Jun 2005 08:47:51 -0700 (PDT)
roger blofeld <blofeldus@yahoo.com> wrote:

> Hi
>  In the 2.6.13-rc1 code the "rn" structure is in the wrong-endianness
> when
> passed to w1_attach_slave_device(). This causes problems like the
> family and crc being swapped around. The following patch fixes the
> problem for me.
> 
>  I sent this earlier to greg k-h & lkml, but he said I should send it
> here first.

Sorry for long delay - I agree with your patch and will push it upstream.
Thank you.

> Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
