From: Yong Wang <yong.y.wang@linux.intel.com>
Date: Mon, 11 Jan 2010 06:20:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix TjMax for
Message-Id: <20100111062024.GA20804@ywang-moblin2.bj.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091224073102.GA23058@ywang-moblin2.bj.intel.com> <20100106160817.72313551@hyperion.delvare> <20100110200621.564a6682@hyperion.delvare>
In-Reply-To: <20100110200621.564a6682@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Huaxu Wan <huaxu.wan@intel.com>, lm-sensors@lm-sensors.org

On Sun, Jan 10, 2010 at 08:06:21PM +0100, Jean Delvare wrote:
> 
> Hmm. Thinking about it some more... What about nVidia-based systems?
> Can't we have systems with an Atom N450/D410/D510 and a non-Intel
> chipset?
> 

No matter what chipset or gfx you use with the new Atom chip, the
integrated memory controller (IMC) will always be used. This patch
checks the presence of that IMC. Hope this clarifies.

Thanks
-Yong


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
