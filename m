From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Jun 2009 07:49:11 +0000
Subject: Re: [lm-sensors] How to un-ignore a sensor?
Message-Id: <20090630094911.2f7447c1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090629211323.32695.qmail@science.horizon.com>
In-Reply-To: <20090629211323.32695.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On 29 Jun 2009 17:13:23 -0400, George Spelvin wrote:
> As I mentioned last year:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-September/024214.html
> 
> I have a motherboard with a sensor hooked up which is ignored in the stock
> sensors3.conf.  (f71882fg-* temp3)
> 
> I'd like to un-ignore it, but there doesn't seem to be a way to do that.
> Looking at the source code, there doesn't seem to be any way to remove or
> mask an entry from the "ignores" list.
> 
> Assuming that feature would be useful, one possible way would be
> to combine that list with the labels list.  An "ignore" statement
> would be a label with a value of NULL.  (Or some other magic sentinel value.)
> 
> That way, it would be possible to override an ignore statement by
> providing a label.
> 
> Does that seem worthwhile?

No, it doesn't. The default sensors.conf file should not include any
ignore statement to start with. And actually it no longer does, so the
problem is already solved.

> (On another note, would it be worth it to implement a basic hash table for
> the various symbol lists?)

I doubt it. With the new default configuration file being much smaller
than it used to be, I do not think lists are a big problem from a
performance perspective. A hash table would probably require more
memory and I'd rather keep the memory footprint low.

That being said, if I am proven wrong, I have no objection to a change.
If you reimplement data storage in libsensors using hash tables and it
is much faster, doesn't need too much additional memory, and doesn't
make the code too complex either, they why not?

> I also have two minor changes, submitted for your consideration:

Patches are easier to review and try when submitted separately.

> commit e139389c4671e2adb3c1db117d700cce7afd75dd
> Author: George Spelvin <linux@horizon.com>
> Date:   Mon Jun 29 11:53:53 2009 +0000
> 
>     Consolidate strdup calls in sensors_get_label
>     
>     There were multiple in-line calls that then fell through to
>     a common exit.  Instead, set up a pointer to the original
>     strings, and have a single strdup in the common code.
> 
> diff --git a/lib/access.c b/lib/access.c
> index af296ab..e29664e 100644
> --- a/lib/access.c
> +++ b/lib/access.c
> @@ -178,7 +178,7 @@ char *sensors_get_label(const sensors_chip_name *name,
>  	for (chip = NULL; (chip = sensors_for_all_config_chips(name, chip));)
>  		for (i = 0; i < chip->labels_count; i++)
>  			if (!strcmp(feature->name, chip->labels[i].name)) {
> -				label = strdup(chip->labels[i].value);
> +				label = chip->labels[i].value;
>  				goto sensors_get_label_exit;
>  			}
>  
> @@ -186,20 +186,22 @@ char *sensors_get_label(const sensors_chip_name *name,
>  	snprintf(path, PATH_MAX, "%s/%s_label", name->path, feature->name);
>  	
>  	if ((f = fopen(path, "r"))) {
> -		i = fread(buf, 1, sizeof(buf) - 1, f);
> +		i = fread(buf, 1, sizeof buf - 1, f);

I wouldn't take that change, I prefer the syntax that uses parentheses,
and it is used consistently in the library code.

>  		fclose(f);
>  		if (i > 0) {
>  			/* i - 1 to strip the '\n' at the end */
>  			buf[i - 1] = 0;
> -			label = strdup(buf);
> +			label = buf;
>  			goto sensors_get_label_exit;
>  		}
>  	}
>  
>  	/* No label, return the feature name instead */
> -	label = strdup(feature->name);
> +	label = feature->name;
>  	
>  sensors_get_label_exit:
> +	label = strdup(label);
> +	
>  	if (!label)
>  		sensors_fatal_error("sensors_get_label",
>  				    "Allocating label text");

This makes sense, I think we can apply this.

> 
> 
> commit 0548c8edf6f939abc1ea47881bad98c26bf48e19
> Author: George Spelvin <linux@horizon.com>
> Date:   Mon Jun 29 11:56:49 2009 +0000
> 
>     sensors_get_label: Merge pathname and label buffers.
>     
>     The lifetimes of the path and label name buffers are
>     disjoint, so a single biffer can be used for both
>     purposes.
> 
> diff --git a/lib/access.c b/lib/access.c
> index e29664e..90c1af1 100644
> --- a/lib/access.c
> +++ b/lib/access.c
> @@ -168,7 +168,7 @@ char *sensors_get_label(const sensors_chip_name *name,
>  {
>  	char *label;
>  	const sensors_chip *chip;
> -	char buf[128], path[PATH_MAX];
> +	char buf[PATH_MAX];
>  	FILE *f;
>  	int i;
>  
> @@ -183,10 +183,10 @@ char *sensors_get_label(const sensors_chip_name *name,
>  			}
>  
>  	/* No user specified label, check for a _label sysfs file */
> -	snprintf(path, PATH_MAX, "%s/%s_label", name->path, feature->name);
> +	snprintf(buf, PATH_MAX, "%s/%s_label", name->path, feature->name);
>  	
> -	if ((f = fopen(path, "r"))) {
> -		i = fread(buf, 1, sizeof buf - 1, f);
> +	if ((f = fopen(buf, "r"))) {
> +		i = fread(buf, 1, sizeof buf, f);
>  		fclose(f);
>  		if (i > 0) {
>  			/* i - 1 to strip the '\n' at the end */

Indeed, this seems a worthwhile optimization.

The license of libsensors will change from GPL to LGPL on July 1st,
2010. Before I apply your patches, please confirm that you have no
objection to your code being released under the LGPL.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
