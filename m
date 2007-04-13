From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Apr 2007 14:20:53 +0000
Subject: Re: [lm-sensors] chipsets on Tyan S5197 and S3095
Message-Id: <20070413162053.3119fc28@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176305335.18788.11.camel@kramer>
In-Reply-To: <1176305335.18788.11.camel@kramer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

Please fix your From and Reply-To fields.

On Wed, 11 Apr 2007 17:28:55 +0200, Marcus Sobchak wrote:
> before buying a new board, could someone tell me, if the following
> chipsets are supported. I've checked the Wiki
> ( http://www.lm-sensors.org/wiki/Devices ) and figured out, that 82801G
> (ICH7) is supported (i2c-i801). Does the i2c-i801 driver support ICH7R
> und ICH7M-DH chipsets too?

Yes, the SMBus block of all the ICH7 variants is the same, so the
i2c-i801 driver supports them all since Linux kernel 2.6.11.

> Mainboard:
>   Toledo i3010W (S5197)
> Chipset: 
>   Intel 3010 + PXH-V + ICH7R
> Website:
>   http://www.tyan.de/product_board_detail.aspx?pid50
> 
> 
> Mainboard:
>   Tomcat i945GM (S3095)
> Chipset: 
>   Intel 945GM memory controller hub
>   Intel ICH7M-DH I/O controller hub
> Website:
>   http://www.tyan.de/product_board_detail.aspx?pid2
> 
> Hints on other new Tyan boards, which are supported are welcome.

The ICH7 doesn't include sensors, only (as far as sensors are
concerned) an SMBus controller. Given that you are posting to the
lm-sensors list, I guess that what you are really interested in is
hardware monitoring support? If so, you'll need to look deeper in the
specifications.

For the Toledo i3010W, the site mentions an "Integrated H/W monitoring
functions in Super I/O chip with PECI support" but doesn't give the
name, so obviously we can't tell if it's supported or not. You'll need
to find the exact Super-I/O chip name.

For the Tomcat i945GM it's even more vague, they don't say if the
hardware monitoring chip is a Super-I/O or an SMBus device. Again
you'll need to find the exact device name if you want to know if it's
supported.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
