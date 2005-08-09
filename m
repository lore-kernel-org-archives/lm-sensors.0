From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Tue, 09 Aug 2005 00:59:25 +0000
Subject: [lm-sensors] Re: General Protection Fault with bcmsensors
Message-Id: <2538186705080815587ddfaccb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/8/05, Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> None of the kernel patches work for recent kernels. I'm not entirely sure
> since when exactly it began, but from a certain point those patches on
> the sf.net cased to work properly and began to crash like that.
> 
> Recently there were some fixes that needed to be done in order to make
> those patches on sf.net compile (changes in i2c structures), but though it
> compiled, it crashed.
> 
> So I thought I'll try the CVS bmcsensors-26. Those compiled without a
> problem (that's probably the patch you are referring to and perhaps
> simillar that I was using), but it crashes the same way as well. So I
> think there may be some other problem introduced somewhere else in recent
> kernels. Tomorrow when I get a chance to safely reboot the server I may
> try to find when it was last working. From what I can briefly see from the
> past kernel logs, it seems to have been working with the kernel 2.6.12.2,
> then I tried the 2.6.13-rc4-git4 and it crashed allready. (Both had to be
> patched to compile and for both I used the same patch.)

lol..indeed the problem is something that was introduced into the
kernel at 2.6.13-rc1 - a change by myself :-). The sysfs callbacks
need to be updated (you should have got warnings complaining of an
invalid function pointer when you compiled the module) for newer
kernels, I'll fix that now, and commit it to CVS so you can try it out
tomorrow, and I will try to test this out on my own machines tonight
too.

I'm not paying much attention to bmcsensors at the moment because I'm
busier trying to get changes into the kernel so that I can re-write
the driver (ipmi-sensors) and get it included in mainline.

Thanks,
Yani
