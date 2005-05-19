From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: Configuration info about Asus CUV4x-D
Message-Id: <20050430211832.10395218.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050430165120.GA4827@slimak.info>
In-Reply-To: <20050430165120.GA4827@slimak.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Slimak,

> On Asus CUV4X-D (dual PIII mainboard) temperatures of processors
> reported by bios are the same as reported by chip without any
> computation, so you may write a hint in configuration file.

This is actually the default for as99127f-* already. If it wasn't for
you, maybe you have been starting from an old configuration file (it
happened to be different).

> chip "as99127f-*"
> 
> #For Asus CUV4X-D
> label temp1 "M/B Temp"
> label temp2 "CPU 1"
> label temp3 "CPU 2"
> compute temp2 @, @
> compute temp3 @, @

Such compute lines are equivalent to no compute line at all, so you can
omit them altogether.

I've updated the default configuration file with some notes for dual-CPU
boards based on your hints. Thanks for the report.

-- 
Jean Delvare
