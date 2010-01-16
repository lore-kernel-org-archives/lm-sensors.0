From: Yuhong Bao <yuhongbao_386@hotmail.com>
Date: Sat, 16 Jan 2010 02:02:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix TjMax for Atom
Message-Id: <SNT125-W147C55AB6EB65D41CAAFFFC3680@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091224073102.GA23058@ywang-moblin2.bj.intel.com>
 <20100106160817.72313551@hyperion.delvare>
 <20100110200621.564a6682@hyperion.delvare>,<20100111062024.GA20804@ywang-moblin2.bj.intel.com>
In-Reply-To: <20100111062024.GA20804@ywang-moblin2.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yong.y.wang@linux.intel.com, khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, huaxu.wan@intel.com, lm-sensors@lm-sensors.org


> No matter what chipset or gfx you use with the new Atom chip, the
> integrated memory controller (IMC) will always be used. This patch
> checks the presence of that IMC. Hope this clarifies.
To be more precise, Pine Trail Atoms integrate the entire northbridge, including the integrated graphics and the memory controller into the CPU, and there is a DMI connection to the southbridge, which is the Intel NM10, that is NOT integrated.
Yuhong Bao 		 	   		  
_________________________________________________________________
Hotmail: Free, trusted and rich email service.
http://clk.atdmt.com/GBL/go/196390708/direct/01/
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
