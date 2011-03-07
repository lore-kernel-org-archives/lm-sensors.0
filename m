From: Robert Kaiser <kairo@kairo.at>
Date: Mon, 07 Mar 2011 14:59:21 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <il2rsa$tpi$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck schrieb:
> This is a Sandy Bridge board, isn't it ?

Yes, it is.

> Maybe you can try a kernel from the -next tree; that might solve your problem.
> That means you would have to download, compile and install the kernel, though.

Hrm, exactly what I want to avoid, updating openSUSE Factory quite often 
already is experimental enough for me on a production machine, but I'm 
using Kernel:HEAD there, which is currently some recent 2.6.38-rc and I 
should be 2.6.39-rc once the merge window has closed.

Still, do you know something I don't on my error that you suggest that? 
Chris Wilson on intel-gfx was somewhat clueless as to why this happens...

> To test a standalone driver, all you have to do is to download it, then run "make"
> followed by "sudo make install". You don't have to build the entire kernel.

That sounds good.
Can I download your standalone driver in a git clone or similar way? 
Pulling the files one by one over http doesn't sound ideal to me. :)

Robert Kaiser


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
