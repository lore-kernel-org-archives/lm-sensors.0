From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 27 Jan 2012 14:23:22 +0000
Subject: Re: [lm-sensors] coretemp ABI breakage during pkgtemp/coretemp merger
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB5902FD36@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F229DD1.9040103@freebox.fr>
In-Reply-To: <4F229DD1.9040103@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> -----Original Message-----
> From: Florian Fainelli [mailto:ffainelli@freebox.fr]
> Sent: Friday, January 27, 2012 6:27 PM
> To: R, Durgadoss; Yu, Fenghua
> Cc: lm-sensors@lm-sensors.org; Guenter Roeck; Maxime Bizon
> Subject: Re: coretemp ABI breakage during pkgtemp/coretemp merger
> 
> Hello again,
> 
> On 01/27/12 13:51, Florian Fainelli wrote:
> > Hello,
> >
> > Commit 199e0de7f5df31a4fc485d4aaaf8a07718252ace: hwmon: (coretemp) Merge
> > pkgtemp with coretemp introduced a breakage on our system (Intel CE4100
> > Atom core HT).
> >
> > pkg_flag = 0 for our particular system, because we don't have
> > X86_FEATURE_PTS set (I have no idea why hardware does not report it,
> > whether this is genuine or not).
> 
> I forgot to explain the real breakage here, this renamed temp1_* to
> temp2_* attributes, thus breaking userland expecting temp1_* attributes.

The Documentation for coretemp explains this change.

Thanks,
Durga
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
