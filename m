From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 29 Jul 2006 01:55:18 +0000
Subject: [lm-sensors] [RFC PATCH] lib/access.c optimization
Message-Id: <20060729015518.GE25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060725041358.GB12109@jupiter.solarsys.private>
In-Reply-To: <20060725041358.GB12109@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

I wrote:
> > The following patch shaves about 8% off the execution time of 'sensors -u'
> > on my workstation (2645586 cycles before vs. 2430821 cycles after).
> > 
> > Can I please get an ACK on this patch before I commit it?  Thanks.

* Jean Delvare <khali at linux-fr.org> [2006-07-28 15:31:52 +0200]:
> This patch ain't trivial, it would help if you could explain what it is
> doing, and how. It seems to be completely different from what you
> showed to me at the OLS?

It's moot if we use hashing, but I'll explain it anyway.  It's actually
very similar to what I showed you... just extended naturally to all the
parts that could benefit from it.

> Index: lib/access.c
> =================================> --- lib/access.c	(revision 4073)
> +++ lib/access.c	(working copy)
> @@ -84,22 +84,44 @@
>  	return NULL;
>  }
>  
> +static const sensors_chip_feature *sensors_lookup_features(const char *prefix)
> +{
> +	static int cache = 0;
> +	int ii = cache;
> +
> +	if (!strcasecmp(sensors_chip_features_list[ii].prefix, prefix))
> +		return sensors_chip_features_list[ii].feature;
> +
> +	for (ii = 0; sensors_chip_features_list[ii].prefix; ii++)
> +		if (!strcasecmp(sensors_chip_features_list[ii].prefix, prefix)){
> +			cache = ii;
> +			return sensors_chip_features_list[ii].feature;
> +		}
> +
> +	return NULL;
> +}
> +

Prior to this patch, all three functions below performed a linear search
through the features list, using the prefix (string) as the search key.
The new function above caches the results of the search so that if you
look for the same key more than once, you'll only need one strcasecmp
per search for the second and subsequent calls.

>  /* Look up a resource in the intern chip list, and return a pointer to it. 
>     Do not modify the struct the return value points to! Returns NULL if 
>     not found.*/
>  const sensors_chip_feature *sensors_lookup_feature_nr(const char *prefix,
>  						      int feature)
>  {
> -	int i, j;
> -	const sensors_chip_feature *features;
> +	static int cache = 0;
> +	int ii = cache;
> +	const sensors_chip_feature *features = sensors_lookup_features(prefix);

The above line replaces...

> -	for (i = 0; sensors_chip_features_list[i].prefix; i++)
> -		if (!strcasecmp(sensors_chip_features_list[i].prefix, prefix)) {
> -			features = sensors_chip_features_list[i].feature;

... those three above.

> -			for (j = 0; features[j].name; j++)
> -				if (features[j].number = feature)
> -					return features + j;
> -		}

The above lines...

> +	if (features) {
> +		if (features[ii].number = feature)
> +			return features + ii;
> +
> +		for (ii = 0; features[ii].name; ii++)
> +			if (features[ii].number = feature) {
> +				cache = ii;
> +				return features + ii;
> +			}
> +
> +	}

... are replaced here, with the same mechanism of locally caching the result
of the prior search.

>  	return NULL;
>  }
>  
> @@ -109,16 +131,20 @@
>  const sensors_chip_feature *sensors_lookup_feature_name(const char *prefix,
>  							const char *feature)

This function is modified in a similar manner to the one above.

>  {
> -	int i, j;
> -	const sensors_chip_feature *features;
> +	static int cache = 0;
> +	int ii = cache;
> +	const sensors_chip_feature *features = sensors_lookup_features(prefix);
>  
> -	for (i = 0; sensors_chip_features_list[i].prefix; i++)
> -		if (!strcasecmp(sensors_chip_features_list[i].prefix, prefix)) {
> -			features = sensors_chip_features_list[i].feature;
> -			for (j = 0; features[j].name; j++)
> -				if (!strcasecmp(features[j].name, feature))
> -					return features + j;
> -		}
> +	if (features) {
> +		if (!strcasecmp(features[ii].name, feature))
> +			return features + ii;
> +
> +		for (ii = 0; features[ii].name; ii++)
> +			if (!strcasecmp(features[ii].name, feature)) {
> +				cache = ii;
> +				return features + ii;
> +			}
> +	}
>  	return NULL;
>  }
>  
> @@ -329,33 +355,36 @@
>  const sensors_feature_data *sensors_get_all_features(sensors_chip_name name,
>  						     int *nr1, int *nr2)

Ditto for this function, although it looks to be more complex.  It might be
easier to look at a diff that ignores whitespace changes; most of the lines
are just change of indentation.

>  {
> -	sensors_chip_feature *feature_list;
> -	int i;
> +	const sensors_chip_feature *feature_list > +				sensors_lookup_features(name.prefix);
>  
> -	for (i = 0; sensors_chip_features_list[i].prefix; i++)
> -		if (!strcasecmp(sensors_chip_features_list[i].prefix, name.prefix)) {
> -			feature_list = sensors_chip_features_list[i].feature;
> -			if (!*nr1 && !*nr2) {	/* Return the first entry */
> -				if (!feature_list[0].name)	/* The list may be empty */
> -					return NULL;
> -				*nr1 = *nr2 = 1;
> -				return (sensors_feature_data *)feature_list;
> -			}
> -			for ((*nr2)++; feature_list[*nr2 - 1].name; (*nr2)++)
> -				if (feature_list[*nr2 - 1].logical_mapping =
> -				    feature_list[*nr1 - 1].number)
> -					return (sensors_feature_data *)
> -						(feature_list + *nr2 - 1);
> -			for ((*nr1)++;
> -			     feature_list[*nr1 - 1].name
> -			     && (feature_list[*nr1 - 1].logical_mapping !> -				 SENSORS_NO_MAPPING); (*nr1)++) ;
> -			*nr2 = *nr1;
> -			if (!feature_list[*nr1 - 1].name)
> -				return NULL;
> -			return (sensors_feature_data *)(feature_list + *nr1 - 1);
> -		}
> -	return NULL;
> +	if (!feature_list)
> +		return NULL;
> +
> +	/* Return the first entry */
> +	if (!*nr1 && !*nr2) {
> +
> +		/* The list may be empty */
> +		if (!feature_list[0].name)
> +			return NULL;
> +
> +		*nr1 = *nr2 = 1;
> +		return (sensors_feature_data *)feature_list;
> +	}
> +
> +	for ((*nr2)++; feature_list[*nr2 - 1].name; (*nr2)++)
> +		if (feature_list[*nr2 - 1].logical_mapping =
> +					feature_list[*nr1 - 1].number)
> +			return (sensors_feature_data *)(feature_list + *nr2 - 1);
> +
> +	for ((*nr1)++; feature_list[*nr1 - 1].name &&
> +		(feature_list[*nr1 - 1].logical_mapping != SENSORS_NO_MAPPING);
> +		(*nr1)++) ;
> +
> +	*nr2 = *nr1;
> +	if (!feature_list[*nr1 - 1].name)
> +		return NULL;
> +	return (sensors_feature_data *)(feature_list + *nr1 - 1);
>  }
>  
>  int sensors_eval_expr(sensors_chip_name chipname, const sensors_expr * expr,

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


