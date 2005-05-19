From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: AS99127F module not detecting fan speeds
Message-Id: <20030820215752.GB29707@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061330215.708.36.camel@chevrolet.hybel>
In-Reply-To: <1061330215.708.36.camel@chevrolet.hybel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Stian Jordet <liste@jordet.nu> [2003-08-19 23:56:55 +0200]:
> Hi,
> 
> I'm very well aware of what you say on your homepage:
> 
> If you have problems, please lobby Asus to release a datasheet.
> Unfortunately several others have without success.
> Please do not send mail to us asking for better as99127f support.
> 
> but I'm not sure if this is just me doing something stupid (which I
> hope), or lack of a feature in the driver. If the latter, I'm sorry for
> disturbing. This is with kernel 2.6, but I had the same issues the last
> time I tried 2.4 (which is a very long time ago.)
> 
> Any hints? Except for buying some hardware which is not Asus...
> 

I see you already got some help on LKML... but this is a FAQ:

> 4.1.1 Fans sometimes/always read 0!!
> 
> You may not have a three-wire fan, which is required.
> 
> You may need to increase the 'fan divisor'. See doc/fan-divisors in our
> package for further information. 

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
