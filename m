From: Steven King <sfking@fdwdc.com>
Date: Sun, 14 Mar 2010 03:29:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <201003131929.13571.sfking@fdwdc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
In-Reply-To: <201002031723.49976.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 07 March 2010 04:23:38 Jean Delvare wrote:
> Hi Steven,

Hi Jean,

> >
> > For my specific use the part is connected to an embedded system and is
> > always enumerated; as lm-sensors doesnt build for this target I wasnt
> > aware of any
>
> Out of curiosity, why is lm-sensors not building? What is missing?

The target is nommu (coldfire) and the build failed with a bunch of
'ERROR: reloc type R_68K_32 is not supported for PIC'.  Probably trivial to 
fix but I havent had the chance to look at it yet.

>
> Nothing spotted by my quick look, but I didn't actually review your
> code. If you post an updated version of your patch, I could review it.

Great!  I'll get an updated patch out right away.


-- 
Steven King -- sfking at fdwdc dot com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
