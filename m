From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 Dec 2012 08:45:41 +0000
Subject: Re: [lm-sensors] i2c tools build failure with gcc 4.6
Message-Id: <20121221094541.5e6125ac@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121220010733.GA31336@roeck-us.net>
	<20121220104510.2fa8a0fb@endymion.delvare>
	<20121220142006.GB32230@roeck-us.net>
	<20121220153735.2ae73802@endymion.delvare>
	<20121220155354.3e600483@endymion.delvare>
	<20121220163945.GB32096@roeck-us.net>
In-Reply-To: <20121220163945.GB32096-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Guenter,

On Thu, 20 Dec 2012 08:39:45 -0800, Guenter Roeck wrote:
> I found the problem. -li2c must be specified after the .o files.
> 
> Patch:
> 
> diff --git a/tools/Module.mk b/tools/Module.mk
> index 1979248..bfd3250 100644
> --- a/tools/Module.mk
> +++ b/tools/Module.mk
> @@ -21,16 +21,16 @@ TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
>  #
>  
>  $(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o
> -	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
> +	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>  
>  $(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> -	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
> +	$(CC) $(LDFLAGS) -o $@ $^  $(TOOLS_LDFLAGS)
>  
>  $(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> -	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
> +	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>  
>  $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> -	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
> +	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>  
>  #
>  # Objects

Hmm, OK. The gcc manual page is somewhat confusing on this topic but as
I understand it, when processing a library, it only considers symbols
which were already referenced but not defined, and discards the rest.
So object files must indeed come first on the command line.

Why it has always worked for me the other way around is a mystery.

You have write permissions to the repository, so please just commit
this fix, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
