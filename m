From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Jul 2006 20:28:49 +0000
Subject: [lm-sensors] [PATCH] atxp1: signed/unsigned char bug
Message-Id: <20060727222849.12c12a43.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060724083118.GB6815@martell.zuzino.mipt.ru>
In-Reply-To: <20060724083118.GB6815@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Thu, Jul 27, 2006 at 08:20:53PM +0200, Jean Delvare wrote:
> > > vid_to_reg() can return -1 and char can be unsigned.
> >
> > What does it take for char be unsigned? Never seen that.
> 
> Cross-gcc for arm here. That's how it was noticed.

I'd call it a bug.

> Or -funsigned-char gcc flag.

Irrelevant as far as the kernel compilation goes - but thanks for the
hint.

I take the patch anyway.

-- 
Jean Delvare

