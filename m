From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 18 Feb 2008 03:08:05 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add Penryn CPU to coretemp
Message-Id: <20080218030805.GG2916@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <478FE9AC.30804@assembler.cz>
In-Reply-To: <478FE9AC.30804@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf:

* Jean Delvare <khali@linux-fr.org> [2008-02-14 09:23:23 +0100]:
> Hi Rudolf,
> 
> On Fri, 18 Jan 2008 00:50:04 +0100, Rudolf Marek wrote:
> > This patch adds support for family 0x17, which has Penryn Core. It should also
> > cover the 8 cores Xeons.
> > 
> > Can someone test please? I think it should work.
> 
> I only have a T2600 (Core Duo), I confirm that there is no regression
> with this patch.
> 
> > 
> > Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> Review: looks OK to me.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
