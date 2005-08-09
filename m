From: drab@kepler.fjfi.cvut.cz (Martin Drab)
Date: Tue, 09 Aug 2005 01:26:58 +0000
Subject: [lm-sensors] Re: General Protection Fault with bcmsensors
Message-Id: <Pine.LNX.4.60.0508090100250.25697@kepler.fjfi.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 8 Aug 2005, Yani Ioannou wrote:

> On 8/8/05, Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> > None of the kernel patches work for recent kernels. I'm not entirely sure
> > since when exactly it began, but from a certain point those patches on
> > the sf.net cased to work properly and began to crash like that.
> > 
> > Recently there were some fixes that needed to be done in order to make
> > those patches on sf.net compile (changes in i2c structures), but though it
> > compiled, it crashed.
> > 
> > So I thought I'll try the CVS bmcsensors-26. Those compiled without a
> > problem (that's probably the patch you are referring to and perhaps
> > simillar that I was using), but it crashes the same way as well. So I
> > think there may be some other problem introduced somewhere else in recent
> > kernels. Tomorrow when I get a chance to safely reboot the server I may
> > try to find when it was last working. From what I can briefly see from the
> > past kernel logs, it seems to have been working with the kernel 2.6.12.2,
> > then I tried the 2.6.13-rc4-git4 and it crashed allready. (Both had to be
> > patched to compile and for both I used the same patch.)
> 
> lol..indeed the problem is something that was introduced into the
> kernel at 2.6.13-rc1 - a change by myself :-). The sysfs callbacks
> need to be updated (you should have got warnings complaining of an
> invalid function pointer when you compiled the module) for newer

You're right. I should have paid more attention to it. (But since GCC 4.x
usually warns about lot's of things during kernel compilation, I didn't 
even read it as long as there are no errors. :( I guess I should. :)

> kernels, I'll fix that now, and commit it to CVS so you can try it out
> tomorrow, and I will try to test this out on my own machines tonight
> too.

That would be great, thanks.

> I'm not paying much attention to bmcsensors at the moment because I'm
> busier trying to get changes into the kernel so that I can re-write
> the driver (ipmi-sensors) and get it included in mainline.

Excellent! So don't let me distract you too much from that. ;-)

BTW, just a silly question: Is there a reason why I can't get the limit 
values for each sensor from the driver? I get just the immediate values of 
temperatures, fan speeds, etc., but all the limits are just set to 0. Is 
it that the server management card (MSI-9549) doesn't support/export them 
(that would be quite odd), or is it that the function just isn't 
implemented in the driver yet?

Martin
