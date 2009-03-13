From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Mar 2009 08:47:06 +0000
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <20090313094706.0f94a613@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wei,

On Fri, 13 Mar 2009 09:28:15 +0800, Wsong@nuvoton.com wrote:
> Hi Jean,
> 
> Thank you for your response.
> 
> I named main driver file as "wb83795.c" just for fit the Makefile. Please
> change its name to fit other drivers in kernel.

OK, we will rename it to w83795.c when we merge it.

> The attach file is the i2cdump result.

Thanks. I've used it to test the updated patch for sensors-detect, and
it worked well. I've committed the patch now. You can try the latest
version of the sensors-detect script, it should work OK for you as well:
  http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

> In fact I have made some subversions for kernel 2.6.5 (Suse 9), kernel
> 2.6.9 (RHEL 4), kernel 2.6.21 and kernel 2.6.27. You can contact with me
> if you need them.

OK, I'll try to remember if a user ever asks for this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
