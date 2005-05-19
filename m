From: ttoohey@toowards.com (Tim Toohey)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: segfault in sensord (lm_sensors2 2.8.5)
Message-Id: <200403092108.45369.ttoohey@toowards.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403080911.40544.ttoohey@toowards.com>
In-Reply-To: <200403080911.40544.ttoohey@toowards.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 09 March 2004 05:01, you wrote:
> > In prog/sensord/rrd.c (since revision 1.5 I think) there's a null
> > pointer dereference when used with the --load-average option. This
> > seems to only be a problem when initialing creating the rrd log file
> > (though I'm not sure).
> >
> > Below is my fix.
>
> I've applied a slightly different one (inlined below). Yours would
> arbitrarily apply voltage-like sanity limits to the feature.
>
> Please confirm that it works OK for you.

I can confirm that it runs OK.
That is, it doesn't segfault. I'm not looking at sanity limits (I'm not sure 
when they would appear in my setup) - my temperature charts look sensible.

>
> Thanks for reporting.
Thanks for letting me :-)

