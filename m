From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Sun, 09 Apr 2006 11:39:50 +0000
Subject: [lm-sensors] [-mm patch] drivers/w1/w1.c: fix a compile error
Message-Id: <20060409113950.GA29990@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060408031405.5e5131da.akpm@osdl.org> <20060409113110.GA8454@stusta.de>
In-Reply-To: <20060409113110.GA8454@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sun, Apr 09, 2006 at 01:31:10PM +0200, Adrian Bunk (bunk at stusta.de) wrote:
> This patch fixes the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/w1/w1.o
> drivers/w1/w1.c:197: error: static declaration of 'w1_bus_type' follows non-static declaration
> drivers/w1/w1.h:217: error: previous declaration of 'w1_bus_type' was here
> make[2]: *** [drivers/w1/w1.o] Error 1
> 
> <--  snip  -->
>
> Signed-off-by: Adrian Bunk <bunk at stusta.de>

Thank you, Adrian, your patch is correct.

-- 
	Evgeniy Polyakov

