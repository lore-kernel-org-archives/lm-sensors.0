From: Robert Hancock <hancockrwd@gmail.com>
Date: Sun, 17 Jan 2010 19:29:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix TjMax for Atom
Message-Id: <4B536502.20102@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091224073102.GA23058@ywang-moblin2.bj.intel.com>	<20100106160817.72313551@hyperion.delvare>	<20100110200621.564a6682@hyperion.delvare>	<20100111062024.GA20804@ywang-moblin2.bj.intel.com>	<SNT125-W147C55AB6EB65D41CAAFFFC3680@phx.gbl> <20100117161518.4912be7c@hyperion.delvare>
In-Reply-To: <20100117161518.4912be7c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Yuhong Bao <yuhongbao_386@hotmail.com>, yong.y.wang@linux.intel.com, linux-kernel@vger.kernel.org, huaxu.wan@intel.com, lm-sensors@lm-sensors.org

On 01/17/2010 09:15 AM, Jean Delvare wrote:
> On Fri, 15 Jan 2010 18:02:27 -0800, Yuhong Bao wrote:
>>
>>> No matter what chipset or gfx you use with the new Atom chip, the
>>> integrated memory controller (IMC) will always be used. This patch
>>> checks the presence of that IMC. Hope this clarifies.
>> To be more precise, Pine Trail Atoms integrate the entire northbridge, including the integrated graphics and the memory controller into the CPU, and there is a DMI connection to the southbridge, which is the Intel NM10, that is NOT integrated.
>
> What prevents another vendor from selling a compatible south bridge
> then?

Nothing (other than licensing for the DMI bus, see NVIDIA and the 
problems this creates for their ION chipset). I'm assuming this patch is 
checking for the host bridge device though, that is integrated into the 
CPU and would always be present.

>
> I start believing that we'd rather identify these Atom models using
> CPUID rather than a PCI device.
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
