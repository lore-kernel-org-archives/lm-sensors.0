From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Fri, 23 Nov 2007 15:53:46 +0000
Subject: Re: [lm-sensors] switching from at91 to gpio driver
Message-Id: <20071124.005346.93019610.anemo@mba.ocn.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071115T225659-359@post.gmane.org>
In-Reply-To: <loom.20071115T225659-359@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Nov 2007 22:42:36 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Applied, thanks. Does this need to go in 2.6.24?

I don't think so.  This is not a regression.  But I believe this fix
is safe for even stable releases.

---
Atsushi Nemoto

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
