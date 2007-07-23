From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jul 2007 18:31:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] Simplify sensors_get_all_features()
Message-Id: <20070723203121.45f3c44d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722163735.3c0df2bb@hyperion.delvare>
In-Reply-To: <20070722163735.3c0df2bb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 23 Jul 2007 11:50:35 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I'm not happy with type = SENSORS_FEATURE_UNKNOWN when not present. I
> > believe that a missing feature should not be listed at all.
> 
> I concidered this too, but I want an application to be able to write
> if (main_feature->sub_features[SENSORS_FEATURE_IN_MAX].mode)
>    // display max value for this in sensor
> 
> This is why I made it a sparse (as in some entries are invalid) array instead 
> of a pointer to a dynamicly allocated array.
> 
> Alternatively, we would not have subfeatures in the main_feature struct at all, 
> but have a:
> double sensors_get_sub_feature(sensors_chip_name name, int main_feature,
>     int subfeature_type);

Yes, that's (almost) what I had in mind. I prefer this over a sparse
array.

> Which will return the value of subfeature if present and 
> SENSORS_FEATURE_NOT_PRESENT (which will be HUGE_VAL) otherwise.

I'm not a big fan of using HUGE_VAL for errors.

> And change the prototype of sensors_get_feature to match, which I suggest 
> because I dislike the use of pass by reference while there really is only one 
> thing to return. Alternatively we could use the same prototype as 
> sensors_get_feature, with an added int subfeature_type param.

I'd prefer this, yes. Looks cleaner than using HUGE_VAL for errors.

> Actually thinking about this and matching this thought with another part of 
> your reply:
> 
>  > Yes, ultimately I would like to get rid of sensors_get_all_feature().
>  >
>  > But as you can see, the question is now: how far do we want to go?
>  > Because we also don't want to delay lm-sensors-3.0.0 too much.
> 
> I think that thas may be the way to go make sensors_get_all_features() only 
> return main features, and add a sensors_get_sub_feature() function:

Agreed. When I wrote "get rid of sensors_get_all_feature()", I really
meant to add "as it exists now."

> Then we don't need the main_feature / sub_feature struct difference and can 
> thus keep everything as is except for the above change, so that we can do 
> lm_sensors-3.0.0 in a timely fasion.

Indeed. And we can improve the internal implementation later, for
better performance.

> There will no longer be an obvious way for an application to get all 
> subfeatures then, but is it a problem that an application cannot get 
> subfeatures it doesn't know about / doesn't know how to handle them?

Good question. Looking at the code of xsensors, it really wants
specific subfeatures. "sensors" wants them all though. This is why it
is important to have several applications in mind when designing an API.

Note that nothing prevents us from offering an additional function to
get all subfeatures, working the same way sensors_get_all_features()
does on main features.

One thing I still need to check is how the early revisions of the GL518
are handled (voltage channels with limits but no input value.) This is
weird but it exists so out model needs to handle it properly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
