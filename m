From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 May 2012 16:02:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Improve support of recent Atom CPU models
Message-Id: <20120530180234.413aa8eb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120530132956.6161d552@endymion.delvare>
In-Reply-To: <20120530132956.6161d552@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander,

On Wed, 30 May 2012 17:55:25 +0200, Alexander Stein wrote:
> Am Mittwoch, 30. Mai 2012, 13:29:56 schrieb Jean Delvare:
> > @@ -85,6 +86,8 @@ Process		Processor					TjMax(C)
> >  		N475/470/455/450				100
> >  		N280/270					90
> >  		330/230						125
> > +		E680/660/640/620				90
> > +		E680T/660T/640T/620T				110
> >  
> >  45nm		Core2 Processors
> >  		Solo ULV SU3500/3300				100
> 
> Maybe it makes sense to state here explicitly that the 110 degree TjMax for the E6XXT series cannot be autodetected and the user should use tjmax module parameter.

Same holds for many other models, unfortunately, but there's no reason
to treat the E600T series differently.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
