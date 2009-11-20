From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Fri, 20 Nov 2009 01:08:33 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] [loongson] yeeloong2f: add platform
Message-Id: <1258679313.1808.13.camel@falcon.domain.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
	 <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com>
	 <1258653766.14308.13.camel@falcon.domain.org>
	 <4B05BBC6.2010000@ru.mvista.com>
In-Reply-To: <4B05BBC6.2010000@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, Richard Purdie <rpurdie@rpsys.net>, lm-sensors@lm-sensors.org, Jamey Hicks <jamey@crl.dec.com>

On Fri, 2009-11-20 at 00:42 +0300, Sergei Shtylyov wrote:
[...]
> >  
> > -static void yeeloong_apm_get_power_status(struct apm_power_info *info)
> > +static void __maybe_unused yeeloong_apm_get_power_status(struct
> > apm_power_info
> > +		*info)
> >   
> 
>    Your patch is line-wrapped.
> 
Yes, I found it, thanks! I have merged this one into "[PATCH v1]
[loongson] yeeloong2f: add platform specific support".

Best Regards,
	Wu Zhangjin


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
