From: Stanislav Brabec <utx@penguin.cz>
Date: Mon, 11 Jul 2011 20:56:31 +0000
Subject: Re: [lm-sensors] [Zaurus-devel] [PATCH v2] MAX1111: Fix Race
Message-Id: <1310417791.17423.3.camel@utx.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
In-Reply-To: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Pavel Herrmann wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> having this structure static is not thread-safe, potentially causing one
> thread having pointers to memory on or above other threads stack. use mutex
> to prevent multiple access
> 
> Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Cyril Hrubis <metan@ucw.cz>
Tested-by: Stanislav Brabec <utx@penguin.cz>

Tested on spitz, fixed previously reproducible OOPSes and kernel panic.

(See thread "kernel panic in spi_complete() on spitz (PXA270)" in
linux-arm-kernel@lists.infradead.org.)

-- 

________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
