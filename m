From: Reinhard Nissl <rnissl@gmx.de>
Date: Sat, 13 Dec 2008 22:39:50 +0000
Subject: Re: [lm-sensors] Winbond W83667HG Super IO Sensors
Message-Id: <494439B6.5070906@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4943F25E.3080806@gmx.de>
In-Reply-To: <4943F25E.3080806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare schrieb:

> On Sat, 13 Dec 2008 18:35:26 +0100, Reinhard Nissl wrote:
>> sensors-detect reports 'to-be-written'. Is someone already
>> working on this driver?
> 
> Yes, Gong Jun (Cc'd) is working on adding support to the w83627ehf
> driver already. He posted a patch [1] which I have reviewed [2] and
> updated a bit [3]. It might be a bit difficult to grab from the list
> archive so I am making it temporarily available for download at:
> http://jdelvare.pck.nerim.net/sensors/hwmon-add-support-for-w83667hg.patch
> You are very welcome to test it and report.

Thanks for your reply. I've found this patch meanwhile myself
too. I'm currently building a new kernel which contains the patch.

> At this point I consider the patch usable but it needs some more work
> for upstream acceptance (at least in the form of a comment about the
> in6 special code, and maybe some related code changes.) I am waiting
> for Gong Jun to comment on my review.

I've seen your comment about in6 and share your opinion. BTW:
motherboard is ASUS P6T WS Professional.

> [1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024802.html
> [2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024880.html
> [3] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024881.html
> 
>> I ported the fscher driver in 2003. Maybe I could try to port
>> some existing driver for this chip too.
> 
> BTW, is this system still in use? We moved support for all FSC chips to
> a unified driver (fschmd). If your system still works, you might want
> to give it a try and report how it's doing for you.

Oh yes, it is still in use. Is the unified driver already part of
kernel 2.6.27.7? If it is, I'll come across is it when I update
the "old" machine to openSUSE 11.1. But this will be quite some
time after the "new" machine is working properly with openSUSE
11.1. So far it took me two weeks to get the harddrive working.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
