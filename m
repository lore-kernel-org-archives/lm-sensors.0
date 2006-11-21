From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Nov 2006 13:58:56 +0000
Subject: [lm-sensors] sensors-detect: Found unknown chip with ID 0x8708
Message-Id: <20061121145856.80949de2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061102183140.595504b5@phearless.godzilla.com>
In-Reply-To: <20061102183140.595504b5@phearless.godzilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeffrey,

On Mon, 20 Nov 2006 11:18:25 -0500, Jeffrey J. Kosowsky wrote:
> Jean Delvare wrote at about 22:08:57 +0100 on Sunday, November 19, 2006:
>  > On Sun, 19 Nov 2006 03:35:15 -0500, Jeffrey J. Kosowsky wrote:
>  > > Now, I learned from the previous post that the SMBus is not enabled if
>  > > suspend is used and that I need to shut off the "Sleep States" in the
>  > > ACPI menu.
>  > > 
>  > > Is there any way to do this *without* recompiling the kernel?
>  > > i.e., can I pass parameters to the kernel in grup or even after
>  > > booting to get rid of the sleep states problem and get SMBus enabled?
>  > 
>  > Unfortunately not. I agree it would be nice to have a kernel boot
>  > parameter for this, but at the moment this is a compilation time
>  > decision. If someone provides a patch to make it a boot time decision,
>  > I'll take that.
> 
> Thanks for the clarification.
> Definitely seems like it should be a boot mode decision since it is a
> harsh either-or choice (either sleep or sensors) that will change
> among different users and even for the same user at different times.
> 
> Recompiling the kernel takes forever and is a pita if it means that
> you can no longer use stock distro kernels.

Agreed, many users complained about this problem already.

> Unfortunately, I am not at the level of kernel hacker to supply you
> with the patch...

You're in luck, Alan Cox just posted a patch on LKML which should fix
the issue.
http://lkml.org/lkml/2006/11/14/161

Users who need the SMBus unhiding quirk, use suspend-to-RAM, and know
how to patch and recompile their kernel, are invited to give it a try
and report.

Thanks,
-- 
Jean Delvare

