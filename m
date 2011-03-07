From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Mar 2011 16:03:50 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <20110307160350.GA13546@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 07, 2011 at 09:59:21AM -0500, Robert Kaiser wrote:
> Guenter Roeck schrieb:
> > This is a Sandy Bridge board, isn't it ?
> 
> Yes, it is.
> 
> > Maybe you can try a kernel from the -next tree; that might solve your problem.
> > That means you would have to download, compile and install the kernel, though.
> 
> Hrm, exactly what I want to avoid, updating openSUSE Factory quite often 
> already is experimental enough for me on a production machine, but I'm 
> using Kernel:HEAD there, which is currently some recent 2.6.38-rc and I 
> should be 2.6.39-rc once the merge window has closed.
> 
> Still, do you know something I don't on my error that you suggest that? 
> Chris Wilson on intel-gfx was somewhat clueless as to why this happens...
> 
All I know is that there is a sequence of patches in linux-next adding several
PCI IDs plus related code to the kernel which seem to be related to Sandy Bridge.
Look for PCI IDs with "DH89XXCC". I am kind of vague here; I was told that the added
PCI IDs match those of Sandy Bridge, but I have not seen the specification myself
so I don't really know for sure.

Do those changes address your problem ? No idea, but it might be worth a try.

> > To test a standalone driver, all you have to do is to download it, then run "make"
> > followed by "sudo make install". You don't have to build the entire kernel.
> 
> That sounds good.
> Can I download your standalone driver in a git clone or similar way? 
> Pulling the files one by one over http doesn't sound ideal to me. :)
> 
The driver is in the hwmon-staging branch of
	http://git.kernel.org/?p=linux/kernel/git/groeck/staging.git

But you'll still need the Makefile from the standalone driver.
	http://www.roeck-us.net/linux/drivers/w83627ehf/Makefile

The only other files you would need are
	http://www.roeck-us.net/linux/drivers/w83627ehf/lm75.h
	http://www.roeck-us.net/linux/drivers/w83627ehf/w83627ehf.c

Just downloading those with wget seems to be more straightforward than creating a git clone.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
