From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 16 Dec 2007 19:25:26 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: No longer depend on libsysfs
Message-Id: <20071216202526.0de03bce@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071129120153.26879145@hyperion.delvare>
In-Reply-To: <20071129120153.26879145@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 16 Dec 2007 13:59:02 -0500, Mark M. Hoffman wrote:
> Hi Jean:
> 
> * Jean Delvare <khali@linux-fr.org> [2007-12-10 14:30:57 +0100]:
> > On Sun, 2 Dec 2007 21:42:39 +0100, Jean Delvare wrote:
> > > Well, I have no reason to believe that anything is wrong with this
> > > patch, as all my testing has been successful. Feel free to apply it to
> > > Rawhide if you want. I would like to commit the change soon, the only
> > > thing I am waiting for at the moment is Mark's ack, as we had been
> > > discussing the matter before, he might want to comment on the approach
> > > I took in my patch.
> > 
> > Patch is committed now.
> 
> I've finally finished reviewing this.  I only have one minor change to
> suggest, which IMHO makes the code a little more readable at very little
> expense in cycles and no expense in size.
> 
> Index: lib/sysfs.c
> =================================> --- lib/sysfs.c	(revision 5072)
> +++ lib/sysfs.c	(working copy)
> @@ -73,7 +73,7 @@
>   * local errors, or a negative error value if any call fails.
>   */
>  static int sysfs_foreach_classdev(const char *class_name,
> -				   int (*func)(char *, const char*))
> +				   int (*func)(const char *, const char *))
>  {
>  	char path[NAME_MAX];
>  	int path_off, ret;
> @@ -105,7 +105,7 @@
>   * local errors, or a negative error value if any call fails.
>   */
>  static int sysfs_foreach_busdev(const char *bus_type,
> -				 int (*func)(char *, const char*))
> +				 int (*func)(const char *, const char *))
>  {
>  	char path[NAME_MAX];
>  	int path_off, ret;
> @@ -455,7 +455,7 @@
>  }
>  
>  /* returns: 0 if successful, !0 otherwise */
> -static int sensors_read_one_sysfs_chip(char *dev_path, const char *dev_name)
> +static int sensors_read_one_sysfs_chip(const char *dev_path, const char *dev_name)
>  {
>  	int domain, bus, slot, fn;
>  	int err = -SENSORS_ERR_KERNEL;
> @@ -539,20 +539,20 @@
>  	return 0;
>  }
>  
> -static int sensors_add_hwmon_device(char *path, const char *classdev)
> +static int sensors_add_hwmon_device(const char *path, const char *classdev)
>  {
> +	char linkpath[NAME_MAX];
>  	char device[NAME_MAX];
> -	int path_off = strlen(path);
>  	int dev_len;
>  	(void)classdev; /* hide warning */
>  
> -	snprintf(path + path_off, NAME_MAX - path_off, "/device");
> -	dev_len = readlink(path, device, NAME_MAX - 1);
> +	snprintf(linkpath, NAME_MAX, "%s/device", path);
> +	dev_len = readlink(linkpath, device, NAME_MAX - 1);
>  	if (dev_len < 0)
>  		return -SENSORS_ERR_KERNEL;
>  	device[dev_len] = '\0';
>  
> -	return sensors_read_one_sysfs_chip(path, strrchr(device, '/') + 1);
> +	return sensors_read_one_sysfs_chip(linkpath, strrchr(device, '/') + 1);
>  }
>  
>  /* returns 0 if successful, !0 otherwise */
> @@ -572,7 +572,7 @@
>  }
>  
>  /* returns 0 if successful, !0 otherwise */
> -static int sensors_add_i2c_bus(char *path, const char *classdev)
> +static int sensors_add_i2c_bus(const char *path, const char *classdev)
>  {
>  	sensors_bus entry;
>  

I'm totally fine with this patch, I agree that it's somewhat cleaner
and the additional cost is negligible. Feel free to apply it to SVN.

Thanks for the review,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
