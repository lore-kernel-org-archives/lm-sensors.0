From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Thu, 07 Jan 2010 08:21:57 +0000
Subject: Re: [lm-sensors] sensors show hdd temp instead of cpu temp using
Message-Id: <20100107082157.GA7536@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
In-Reply-To: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 00:07 Thu 07 Jan, vajorie wrote:
> On Wed, Jan 6, 2010 at 8:59 PM, Huaxu Wan <huaxu.wan@linux.intel.com> wrote:
> 
> Hi,
> 
> Thanks for your response (and it's truly great to hear from intel, as
> a side note). If I got your message right, unfortunately, I'm not
> literate at all about the internal mechanisms of hardware monitoring
> :( All I know is that the temperature that is reported as cpu's by
> coretemp / sensors is actually (I'm pretty sure) that of the hdd. The
> crit temps that sensors report (90C) is accurate according to intel's
> specs for N280, but the temperature is too low for this cpu (right
> now, it's 29C) and it corresponds almost perfectly to hdd temperature
> reported in Windows (checked with a reboot from Linux to Windows). The
> average cpu temp reported in Windows is 50C+...
> 
> Is it possible that what coretemp thinks is MSR is actually not it (I
> don't know what I'm saying at this point)?
> 
> This may be related to how Acer set (wrongly?) things up with Aspire
> One D250 (via their bios??), but I'm not sure about that. Their bios
> (?) already has other problems with this cpu[1].
> 
> I opened yet another bug report in linux kernel about this:
> http://bugzilla.kernel.org/show_bug.cgi?id991 which has one other
> user reporting similar experience on the D250. That bug report also
> has my output of acpidump, if relevant here.
> 
> Thanks again for your reply.
> Is there any way I can help debug this?
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/cpufreqd/+bug/422858


Following the link[1], get the package. Make and run the `./burnP6 &`
twice to occpuy whole CPU. Check whether the coretemp temperature
increase.

[1] http://pages.sbcglobal.net/redelm/cpuburn_1_4_tar.gz

Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
