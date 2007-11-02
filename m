From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 02 Nov 2007 19:41:19 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <472B7D5F.30100@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 02 Nov 2007 08:35:53 +0100, Hans de Goede wrote:
>> Good work Jean, yes that should do the job, I stared myself blind at adding a 
>> clean way to store the data for later retrieval to the existing __init parser, 
>> your way indeed will work and is much more generic.
>>
>> I'll compile a kernel with the dmi_scan.c and dmi.h parts patched in and then 
>> start working on integrating this into fschmd.c
> 
> Here's an updated version of my patch, with no code duplication this
> time. This should be easier to get this accepted upstream. To make the
> code even smaller, dmi_table() could be merged into dmi_present() but
> that's about it.
> 

Looks good, I found inconsistency though, in essence the dmi_table() and 
dmi_walk() are the same, (except for dmi_ioremap versus ioremap ofcourse) but 
for one you just use the base, len and number of items stored in global 
variables, while for the other you pass those same global variables through 
parameters, for consistency sake I think you should to both the same.


>> Question, what do we do if the dmi data doesn't get found, use some defaults I 
>> guess?
> 
> Don't export the voltage values at all? I'd rather not export anything
> than silently export values which may not be correct. But hopefully it
> will never happen so it doesn't really matter what we decide here.
> 

I would rather just printk a warning and use some sane defaults in this 
scenario. We must definetively alert the user, that I agree with. The problem 
with a printk is ofcourse that it will hardly be noticed.

Regards,

Hans





> * * * * *
> 
> Subject: dmi: Let drivers walk the DMI table
> 
> Let drivers walk the DMI table for their own needs. Some drivers need
> data stored in OEM-specific DMI records for proper operation.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/firmware/dmi_scan.c |   59 +++++++++++++++++++++++++++++++++----------
>  include/linux/dmi.h         |    3 ++
>  2 files changed, 49 insertions(+), 13 deletions(-)
> 
> --- linux-2.6.24-rc1.orig/drivers/firmware/dmi_scan.c	2007-11-02 10:27:01.000000000 +0100
> +++ linux-2.6.24-rc1/drivers/firmware/dmi_scan.c	2007-11-02 10:27:19.000000000 +0100
> @@ -36,18 +36,12 @@ static char * __init dmi_string(const st
>   *	We have to be cautious here. We have seen BIOSes with DMI pointers
>   *	pointing to completely the wrong place for example
>   */
> -static int __init dmi_table(u32 base, int len, int num,
> -			    void (*decode)(const struct dmi_header *))
> +static void __dmi_table(u8 *buf, int len, int num,
> +			void (*decode)(const struct dmi_header *))
>  {
> -	u8 *buf, *data;
> +	u8 *data = buf;
>  	int i = 0;
>  
> -	buf = dmi_ioremap(base, len);
> -	if (buf = NULL)
> -		return -1;
> -
> -	data = buf;
> -
>  	/*
>  	 *	Stop when we see all the items the table claimed to have
>  	 *	OR we run off the end of the table (also happens)
> @@ -68,6 +62,19 @@ static int __init dmi_table(u32 base, in
>  		data += 2;
>  		i++;
>  	}
> +}
> +
> +static int __init dmi_table(u32 base, int len, int num,
> +			    void (*decode)(const struct dmi_header *))
> +{
> +	u8 *buf;
> +
> +	buf = dmi_ioremap(base, len);
> +	if (buf = NULL)
> +		return -1;
> +
> +	__dmi_table(buf, len, num, decode);
> +
>  	dmi_iounmap(buf, len);
>  	return 0;
>  }
> @@ -86,6 +93,9 @@ static int __init dmi_checksum(const u8 
>  static char *dmi_ident[DMI_STRING_MAX];
>  static LIST_HEAD(dmi_devices);
>  int dmi_available;
> +static u32 dmi_base;
> +static u16 dmi_len;
> +static u16 dmi_num;
>  
>  /*
>   *	Save a DMI string
> @@ -273,9 +283,9 @@ static int __init dmi_present(const char
>  
>  	memcpy_fromio(buf, p, 15);
>  	if ((memcmp(buf, "_DMI_", 5) = 0) && dmi_checksum(buf)) {
> -		u16 num = (buf[13] << 8) | buf[12];
> -		u16 len = (buf[7] << 8) | buf[6];
> -		u32 base = (buf[11] << 24) | (buf[10] << 16) |
> +		dmi_num = (buf[13] << 8) | buf[12];
> +		dmi_len = (buf[7] << 8) | buf[6];
> +		dmi_base = (buf[11] << 24) | (buf[10] << 16) |
>  			(buf[9] << 8) | buf[8];
>  
>  		/*
> @@ -287,7 +297,7 @@ static int __init dmi_present(const char
>  			       buf[14] >> 4, buf[14] & 0xF);
>  		else
>  			printk(KERN_INFO "DMI present.\n");
> -		if (dmi_table(base,len, num, dmi_decode) = 0)
> +		if (dmi_table(dmi_base, dmi_len, dmi_num, dmi_decode) = 0)
>  			return 0;
>  	}
>  	return 1;
> @@ -470,3 +480,26 @@ int dmi_get_year(int field)
>  	return year;
>  }
>  
> +/**
> + *	dmi_walk - Walk the DMI table and get called back for every record
> + *	@decode: Callback function
> + *
> + *	Returns -1 when the DMI table can't be reached, 0 on success.
> + */
> +int dmi_walk(void (*decode)(const struct dmi_header *))
> +{
> +	u8 *buf;
> +
> +	if (!dmi_available)
> +		return -1;
> +
> +	buf = ioremap(dmi_base, dmi_len);
> +	if (buf = NULL)
> +		return -1;
> +
> +	__dmi_table(buf, dmi_len, dmi_num, decode);
> +
> +	iounmap(buf);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dmi_walk);
> --- linux-2.6.24-rc1.orig/include/linux/dmi.h	2007-11-02 10:27:01.000000000 +0100
> +++ linux-2.6.24-rc1/include/linux/dmi.h	2007-11-02 10:27:19.000000000 +0100
> @@ -78,6 +78,7 @@ extern const struct dmi_device * dmi_fin
>  extern void dmi_scan_machine(void);
>  extern int dmi_get_year(int field);
>  extern int dmi_name_in_vendors(const char *str);
> +extern int dmi_walk(void (*decode)(const struct dmi_header *));
>  
>  #else
>  
> @@ -87,6 +88,8 @@ static inline const struct dmi_device * 
>  	const struct dmi_device *from) { return NULL; }
>  static inline int dmi_get_year(int year) { return 0; }
>  static inline int dmi_name_in_vendors(const char *s) { return 0; }
> +static inline int dmi_walk(void (*decode)(const struct dmi_header *))
> +	{ return -1; }
>  
>  #endif
>  
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
