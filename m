From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 28 Sep 2011 13:18:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ED10F28F@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I have the CPU model of the next generation Atom based Core.
Can we add this also in the list here ?
If you don't find time, I can add the one liner, after this gets in.

)
> +                              0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
> +                              0x26 (Tunnel Creek Atom)

0x27 (Medfield Atom) and TjMax 90

>      Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
>                 Volume 3A: System Programming Guide
>                 http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
> @@ -85,6 +86,8 @@ Process		Processor
> 	TjMax(C)
>  		N475/470/455/450				100
>  		N280/270					90
>  		330/230						125
> +		E660						90
> +		E660T						110
> 
>  45nm		Core2 Processors

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
