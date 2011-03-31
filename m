From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 31 Mar 2011 13:58:16 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" on Asrock ION 330 HT
Message-Id: <20110331135816.GA21547@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201103310124.08484.tomasdeltell@gmx.es>
In-Reply-To: <201103310124.08484.tomasdeltell@gmx.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 31, 2011 at 04:06:28AM -0400, Jean Delvare wrote:
> On Thu, 31 Mar 2011 01:24:08 +0200, Tomàs Deltell Bonell wrote:
> > I'm trying to install w83627ehf driver on my Asrock ION 330 HT with Mandriva 
> > 2010.2, kernel 2.6.33.7 and lm-sensors 3.1.2. When i try to compile i get this 
> > error:
> > 
> > $ make
> >   CC [M]  /home/user/w83627ehf/w83627ehf.o
> > /home/user/w83627ehf/w83627ehf.c: on function ‘w83627ehf_find’:
> > /home/user/w83627ehf/w83627ehf.c:2385: error: implicit declaration of 
> > ‘pr_warn’ function
> > make[2]: *** [/home/user/w83627ehf/w83627ehf.o] Error 1
> > make[1]: *** [_module_/home/user/w83627ehf] Error 2
> > make: *** [modules] Error 2
> > 
> > and i don't know how to continue
> 
> Where do you get this driver from? The one I host at
>   http://khali.linux-fr.org/devel/misc/w83627ehf/
> includes a compatibility patch for the problem you are reporting. And
> the one Guenter is hosting at
>   http://roeck-us.net/linux/drivers/w83627ehf/
> includes variants for older kernels (2.6.18 and RHEL 5.4 as I
> understand it.)
> 
> BTW, Guenter, I don't think it makes sense that we both maintain a
> standalone w83627ehf driver. Mine is lagging behind these days (lacks
> support for the NCT6776F) but yours is less user-friendly IMHO (separate
> source files for older kernels.) Maybe we can combine our efforts to
> have a single, up-to-date and user-friendly driver? First question
> being: do you plan to keep your driver alive at all, or was it just
> there for the times when you were working on adding NCT6776F support?
> 
It was only intended for the NCT6775F/NCT6776F support, so, no, I did
not plan to keep it alive.

> FYI, I am using quilt to maintain my standalone drivers. This lets me
> keep the compatibility layer separated from the original driver code.
> That way it is very easy for me to update to a new base version of the
> driver - I simply pop the compatibility patch, update the driver, push
> the compatibility patch again and refresh it as needed. Then I upload
> the result to my website. I don't know if you have such a workflow on
> your side.
> 
I could do the same with git - just create separate branches for
the different versions. So far I just copied the standalone drivers from
the actual trees, though. In my development flow, I have a separate branch
for each of the drivers I am working on, and sometimes even multiple branches
(eg one for bug fixes, one for cleanup, and one for new development).

I agree that we should only maintain a single version of the standalone driver.
Let me know your preference - I can delete mine and have it point to yours.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
