From: Dan Carpenter <error27@gmail.com>
Date: Wed, 03 Mar 2010 16:59:41 +0000
Subject: Re: [lm-sensors] e5e9f44c causes buffer under-runs
Message-Id: <20100303165941.GA5039@bicker>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100303070914.GE5086@bicker>
In-Reply-To: <20100303070914.GE5086@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Wed, Mar 03, 2010 at 01:43:56PM +0100, Jean Delvare wrote:
> Hi Dan,
> 
> On Wed, 3 Mar 2010 10:09:14 +0300, Dan Carpenter wrote:
> > Smatch complains about:  e5e9f44c2 i2c: Drop I2C_CLIENT_INSMOD_2 to 8
> > 
> > The original define had an "any_chip", but this patch removed it.
> > 
> > -#define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
> > -enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,       \
> > -            chip7, chip8 }
> > 
> > This causes some buffer under runs.
> > 
> > drivers/hwmon/fschmd.c +1040 fschmd_detect(33) warn: array offset '(kind-1)' can be negative (-1)
> > drivers/hwmon/tmp401.c +527 tmp401_detect(37) warn: array offset '(kind-1)' can be negative (-1)
> > drivers/hwmon/tmp421.c +255 tmp421_detect(30) warn: array offset '(kind-1)' can be negative (-1)
> > drivers/hwmon/tmp421.c +256 tmp421_detect(31) warn: array offset '(kind-1)' can be negative (-1)
> > 
> > (From a test version of smatch).
> 
> Thanks a lot for reporting. I was well aware that these drivers would
> need special care when getting rid of the I2C_CLIENT_INSMOD_* macros,
> and I _thought_ I had taken care, I even seem to remember changing the
> code in question... but apparently I managed to lose the changes
> somewhere in the process. Sigh.
> 
> The following patch should fix it. Please apply it, run smatch again
> and confirm the warnings are gone.
> 

Looks good.  You cleaned up the code nicely.

regards,
dan carpenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
