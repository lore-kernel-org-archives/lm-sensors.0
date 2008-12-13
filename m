From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Dec 2008 22:57:49 +0000
Subject: Re: [lm-sensors] Winbond W83667HG Super IO Sensors
Message-Id: <20081213235749.69f25956@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4943F25E.3080806@gmx.de>
In-Reply-To: <4943F25E.3080806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 13 Dec 2008 23:39:50 +0100, Reinhard Nissl wrote:
> > BTW, is this system still in use? We moved support for all FSC chips to
> > a unified driver (fschmd). If your system still works, you might want
> > to give it a try and report how it's doing for you.
> 
> Oh yes, it is still in use. Is the unified driver already part of
> kernel 2.6.27.7? If it is, I'll come across is it when I update

Yes, all kernels since 2.6.24 have the new fschmd driver with support
for all FSC hardware monitoring chips. The only feature which is
missing is the watchdog support, which will only be added in kernel
2.6.29.

> the "old" machine to openSUSE 11.1. But this will be quite some
> time after the "new" machine is working properly with openSUSE
> 11.1. So far it took me two weeks to get the harddrive working.

If you don't use the watchdog feature, the kernel in openSUSE 11.1 will
do just fine. If you do, you'll have to wait some more.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
