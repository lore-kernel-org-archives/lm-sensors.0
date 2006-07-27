From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Thu, 27 Jul 2006 18:30:34 +0000
Subject: [lm-sensors] [PATCH] atxp1: signed/unsigned char bug
Message-Id: <20060727183034.GD6825@martell.zuzino.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060724083118.GB6815@martell.zuzino.mipt.ru>
In-Reply-To: <20060724083118.GB6815@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 27, 2006 at 08:20:53PM +0200, Jean Delvare wrote:
> > vid_to_reg() can return -1 and char can be unsigned.
>
> What does it take for char be unsigned? Never seen that.

Cross-gcc for arm here. That's how it was noticed. Or -funsigned-char
gcc flag.


