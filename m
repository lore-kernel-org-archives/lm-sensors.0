From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Dec 2011 16:54:50 +0000
Subject: Re: [lm-sensors] Support for IT8510E possible?
Message-Id: <20111224165450.GB7736@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAhWNATid2Djcg62fzQyLqeB-M+657EMAXc=vkz1_KN98ZPy_A@mail.gmail.com>
In-Reply-To: <CAAhWNATid2Djcg62fzQyLqeB-M+657EMAXc=vkz1_KN98ZPy_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 24, 2011 at 12:15:47AM -0500, Enoch Leung wrote:
> Hi,
> 
>      I have an old laptop Gateway ML3109 which has a ITE 8510
> (IT8510E?) according to Gateway's specification.  I think the same
> motherboard is used by many Gateway laptop models.  May you help on
> adding support for this chip to lm-sensors?  Thanks.  I am using
> Gentoo and there is no driver for it as of kernel 3.1.5.  According to
> ITE's website, the chip function as KBC (that's what Gateway list it
> as), fan control, hw monitoring and watchdog etc.
> 
> http://search.gateway.com/s/Mobile/Q106/Bishop/4006148R/4006148Rsp2.shtml
> 
Looks like this would require a completely new driver, so someone with a board
would have to have the time to write a driver.

I added your request to the lm-sensors device support page.

I added support for the IT8510E to sensors-detect. It would be great if you can download
http://roeck-us.net/linux/sensors/sensors-detect and run it to see if it works.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
