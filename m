From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Jan 2012 13:22:39 +0000
Subject: Re: [lm-sensors] coretemp ABI breakage during pkgtemp/coretemp merger
Message-Id: <20120127142239.5ae3ff1e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F229DD1.9040103@freebox.fr>
In-Reply-To: <4F229DD1.9040103@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 Jan 2012 13:57:16 +0100, Florian Fainelli wrote:
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

I don't expect Atom CPUs to have multiple thermal sensors, so that's
probably correct.

> I forgot to explain the real breakage here, this renamed temp1_* to 
> temp2_* attributes, thus breaking userland expecting temp1_* attributes.

No, this isn't an ABI breakage. Attributes got renumbered but their new
names still comply with the documented sysfs interface to hwmon devices.

This change indeed requires some changes to configuration files, most
notably /etc/fancontrol. It will also require recreating the sensord
rrd database, but so does pretty much every configuration change, this
is really a design issue in sensord.

You did not even describe what your actual "breakage" was.

It's a little late to complain about this 8 months later. Back then it
was decided that the benefits were worth it, and I still believe this
was the right decision. The original driver design was simply wrong.
We're obviously not going to revert this now, as this would be one more
ABI change for users currently running kernels 3.0 to 3.3.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
