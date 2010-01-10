From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jan 2010 19:06:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix TjMax for Atom
Message-Id: <20100110200621.564a6682@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091224073102.GA23058@ywang-moblin2.bj.intel.com>
	<20100106160817.72313551@hyperion.delvare>
In-Reply-To: <20100106160817.72313551@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Huaxu Wan <huaxu.wan@intel.com>, lm-sensors@lm-sensors.org

On Wed, 6 Jan 2010 16:08:17 +0100, Jean Delvare wrote:
> Hi Yong,
> 
> On Thu, 24 Dec 2009 15:31:02 +0800, Yong Wang wrote:
> > The max junction temperature of Atom N450/D410/D510 CPUs is 100 degrees Celsius.
> > Since these CPUs are always coupled with Intel NM10 chipset in one package, the
> > best way to verify whether an Atom CPU is N450/D410/D510 is to check the host
> > bridge device.
> > 
> > Signed-off-by: Yong Wang <yong.y.wang@intel.com>
> > Acked-by: Huaxu Wan <huaxu.wan@intel.com>
> 
> Applied, thanks. I've also added a Kconfig dependency on CONFIG_PCI.

Hmm. Thinking about it some more... What about nVidia-based systems?
Can't we have systems with an Atom N450/D410/D510 and a non-Intel
chipset?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
