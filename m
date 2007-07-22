From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 15:01:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] Simplify sensors_get_all_features()
Message-Id: <46A37142.5070900@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722163735.3c0df2bb@hyperion.delvare>
In-Reply-To: <20070722163735.3c0df2bb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> The way we build the feature lists guarantees that subfeatures always
> immediately follow their main feature. This makes it possible to simplify
> sensors_get_all_features() quite a bit. We no longer need to maintain
> separate pointers for the last main feature and the last subfeature,
> we can simply walk the list linearly.
> 

Sounds & looks good. I'm not all to familiar with the internals of
sensors_get_all_features() though, so I might have missed something, but the 
changes look ok to me.


> Note that I am still not entirely happy with this API. It was obviously
> designed for debugging purposes (sensors -u) and without performance
> concernes nor interface cleanliness in mind. I believe that we want to
> tag main features and subfeatures as such, and let the application ask
> specifically for the list of main features, and for each feature, for
> its list of subfeatures (i.e. two functions instead of one.)

I am thinking very much along the same lines. Maybe however, it would be better 
to only have an iteration function for mainfeatures, and have seperate structs 
for sub_features and main_features like this:

typedef struct sensors_sub_feature_data {
   const char *name;
   int type;  // SENSORS_FEATURE_UNKNOWN when not present
   int flags; // mode + use main feature compute rule flag, 0 when not present
} sensors_sub_feature_data;


typedef struct sensors_main_feature_data {
   const char *name;
   int type;
   int mode;
   /* SENSORS_FEATURE_MAX_SUB_FEATURES - 1, because
      SENSORS_FEATURE_MAX_SUB_FEATURES includes the main feature,
      maybe we should change this? */
   sensors_sub_feature_data sub_features[SENSORS_FEATURE_MAX_SUB_FEATURES - 1];
} sensors_feature_data;

Then the application itself could easily see which subfeatures are available, a 
potential problem with this approach is that the size of the 
sensors_main_feature_data struct will change if we add new sub-feature types, 
causing  SENSORS_FEATURE_MAX_SUB_FEATURES to grow. If we however always return 
a pointer to sensors_main_feature_data, then the struct growing is not a 
problem. An application will just not use / look for the new sub_features.

We could then also have a matching sensors_get_feature which takes an array of 
doubles, reading all values at once, which gets passed an array size, so that 
an app can say I'm only interested in the main feature + the first X sub features.

Notice that I removed the number from the feature data, instead the name could 
be directly passed to sensors_get_feature, afaik we have no need for the number 
any more. Hmm, maybe we do for the compute_mappings.

If we go this way, the feature data inside libsensors could be stored in the 
same way, maybe we can then even completely remove sensors_get_all_features, 
and just add a pointer to an array of main_features to the chip structs being 
passed around. This array would be terminated with a main_feature entry with a 
name of NULL.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
