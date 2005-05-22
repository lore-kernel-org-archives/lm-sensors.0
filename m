From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 May 2005 15:32:50 +0000
Subject: [lm-sensors] Memory leak in sensors_get_label()
Message-Id: <20050522153235.467c6297.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
In-Reply-To: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,

> there seems to be a minor memory leak in the sensors_get_label() call 
> in the lm-sensors library, version 2.9.1.  The code in question is as 
> follows, from lib/access.c:
> 
> [...]
> 
> 171     } else if (alt_featureptr && 
> 172                !strcasecmp(alt_featureptr->name, chip->labels[i].name)) {
> 173       if (*result)
> 174         free(*result);
> 175       if (! (*result = strdup(chip->labels[i].value)))
> 176         sensors_fatal_error("sensors_get_label","Allocating label text");
> 177     }
> 178 if (! (*result = strdup(featureptr->name)))
> 179   sensors_fatal_error("sensors_get_label","Allocating label text");
> 180 return 0;
> 
> You can see that if line 175 gets executed, then the memory it
> allocates is going to be leaked at line 178 where the *result
> pointer is overwritten.

Correct.

>   It seems to me that there should either be a "return 0;" statement 
> between lines 176 and 177, to return with *result pointing at the copy
> of chip->labels[i].value,

No, this would return as soon as a non-exact match happens. The idea
behind the algorithm is to gather non-exact labels until an exact match
happens, or the end of the loop is reached.

> or else *result should not be being assigned in this instance.

I think it is correct to assign it, but it should then not be
overwritten by the trailing default case. IOW, there should be:

  if (*result)
    return 0;

between lines 177 and 178. Or so I think.

> To be honest, I don't really understand what the code here is trying
> to achieve, being a bit of an lm-sensors noob -- I was only looking
> at it to track down the memory leak. Hopefully you can advise what
> the correct fix is.

Thanks a lot for looking into this. We know there are a few leaks in
libsensors, most of which are in the configuration file parser, and none
of us know how to fix them. The one you have been revealing was gone
unnoticed so far, it seems.

I think that the code attempts to do the following:
1* If a label is found for the given feature, return it.
2* If the feature has no label but has a logical parent which has a
label, return that label.
3* If no label is found, return the name of the feature itself.

Currently, 3* will override 2* instead of being used as a last resort
solution, as it should. That's where the leak happens. Good catch :)

We can't blame you for not understanding how that code works. It's not
exactly elegant, let alone the terrible coding style and lack of
comments.

The immediate solution would be to add the conditional return I
mentioned above. However, I don't think that the way the function works
is great by itself. Returning the logical parent's label doesn't make
any sense to me. I'd rather see the feature name rather than the
parent's label, it's more likely to tell me what the feature is meant
for.

What do the other folks here think?

> Clearly this isn't a problem for one-shot programs, but polling twice
> a minute we are leaking about 100 bytes a time, which is over 200k per
> day -- a bit of a nuisance on an embedded platform.

Yes of course. Leaks are bad anyway, so let's kill that one. What tool
are you using BTW? sensord?

I've attached my proposed patch. Please give it a try. If it works for
you and nobody objects to the way it changes the function, I'll apply it
to lm_sensors CVS.

And if you happen to spot other leaks ruining your embedded platforms,
please let us know, and we'll try to hunt them down.

Thanks,
-- 
Jean Delvare
-------------- next part --------------
Index: lib/access.c
=================================RCS file: /home/cvs/lm_sensors2/lib/access.c,v
retrieving revision 1.25
diff -u -r1.25 access.c
--- lib/access.c	19 Sep 2004 17:37:18 -0000	1.25
+++ lib/access.c	22 May 2005 13:50:33 -0000
@@ -139,14 +139,12 @@
 
 /* Look up the label which belongs to this chip. Note that chip should not
    contain wildcard values! *result is newly allocated (free it yourself).
-   This function will return 0 on success, and <0 on failure.  
-   Changed behaviour as of libsensors.so.1: now we actually take notice
-   of the logical class, as documented, but not done before! */
+   This function will return 0 on success, and <0 on failure.
+   If no label exists for this feature, its name is returned itself. */  
 int sensors_get_label(sensors_chip_name name, int feature, char **result)
 {
   const sensors_chip *chip;
   const sensors_chip_feature *featureptr;
-  const sensors_chip_feature *alt_featureptr;
   int i;
 
   *result=NULL;
@@ -154,12 +152,7 @@
     return -SENSORS_ERR_WILDCARDS;
   if (! (featureptr = sensors_lookup_feature_nr(name.prefix,feature)))
     return -SENSORS_ERR_NO_ENTRY;
-  if (featureptr->logical_mapping = SENSORS_NO_MAPPING)
-    alt_featureptr = NULL;
-  else if (! (alt_featureptr -                   sensors_lookup_feature_nr(name.prefix,
-                                             featureptr->logical_mapping)))
-    return -SENSORS_ERR_NO_ENTRY;
+
   for (chip = NULL; (chip = sensors_for_all_config_chips(name,chip));)
     for (i = 0; i < chip->labels_count; i++)
       if (!strcasecmp(featureptr->name, chip->labels[i].name)) {
@@ -167,14 +160,10 @@
           free(*result);
         if (! (*result = strdup(chip->labels[i].value)))
           sensors_fatal_error("sensors_get_label","Allocating label text");
-        return 0; /* Exact match always overrules! */
-      } else if (alt_featureptr && 
-                 !strcasecmp(alt_featureptr->name, chip->labels[i].name)) {
-        if (*result)
-          free(*result);
-        if (! (*result = strdup(chip->labels[i].value)))
-          sensors_fatal_error("sensors_get_label","Allocating label text");
+        return 0;
       }
+
+  /* No label, return the feature name instead */
   if (! (*result = strdup(featureptr->name)))
     sensors_fatal_error("sensors_get_label","Allocating label text");
   return 0;
