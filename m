From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jan 2010 20:05:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix TjMax for Atom
Message-Id: <20100117210536.0ae0f187@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091224073102.GA23058@ywang-moblin2.bj.intel.com>
	<20100106160817.72313551@hyperion.delvare>
	<20100110200621.564a6682@hyperion.delvare>
	<20100111062024.GA20804@ywang-moblin2.bj.intel.com>
	<SNT125-W147C55AB6EB65D41CAAFFFC3680@phx.gbl>
	<20100117161518.4912be7c@hyperion.delvare>
	<4B536502.20102@gmail.com>
In-Reply-To: <4B536502.20102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Yuhong Bao <yuhongbao_386@hotmail.com>, yong.y.wang@linux.intel.com, linux-kernel@vger.kernel.org, huaxu.wan@intel.com, lm-sensors@lm-sensors.org

On Sun, 17 Jan 2010 13:29:06 -0600, Robert Hancock wrote:
> On 01/17/2010 09:15 AM, Jean Delvare wrote:
> > On Fri, 15 Jan 2010 18:02:27 -0800, Yuhong Bao wrote:
> >>
> >>> No matter what chipset or gfx you use with the new Atom chip, the
> >>> integrated memory controller (IMC) will always be used. This patch
> >>> checks the presence of that IMC. Hope this clarifies.
> >> To be more precise, Pine Trail Atoms integrate the entire northbridge, including the integrated graphics and the memory controller into the CPU, and there is a DMI connection to the southbridge, which is the Intel NM10, that is NOT integrated.
> >
> > What prevents another vendor from selling a compatible south bridge
> > then?
> 
> Nothing (other than licensing for the DMI bus, see NVIDIA and the 
> problems this creates for their ION chipset). I'm assuming this patch is 
> checking for the host bridge device though, that is integrated into the 
> CPU and would always be present.

That's where I am confused. The patch checks for the presence of the
Intel NM10, which, reading its description looks much like a south
bridge and not a memory controller (north bridge). So I think the patch
is wrong (or at least incomplete).

Anyway, how difficult would it be to set TjMax based on the CPUID? I
presume that the Intel Atom 400 and 500 series have their own CPUID
value, haven't they? This would seem even easier that checking for a
PCI device.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
