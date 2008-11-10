From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 10 Nov 2008 18:38:19 +0000
Subject: Re: [lm-sensors] a problem with lm-sensor 2.10.7.
Message-Id: <Pine.LNX.4.64.0811101229510.13024@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
In-Reply-To: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 10 Nov 2008, Sergio Gutierrez Verde wrote:
> double w83781d(const sensors_chip_name *name)
> {
>  double cur;
>
>  sensors_get_feature(*chip_name,SENSORS_W83781D_TEMP2,&cur)
>  return(cur);
> }

Since you used "*name" in the argument, probably

sensors_get_feature(*name,SENSORS_W83781D_TEMP2,&cur)

would work better.  What you are doing now is probably equal to

sensors_get_feature(NULL,SENSORS_W83781D_TEMP2,&cur)

which would likely cause the error.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
