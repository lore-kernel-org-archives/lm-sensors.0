From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Aug 2013 14:57:25 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <20130827165725.1a6e6666@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Aug 2013 20:18:08 +0530, Sachin Kamat wrote:
> On 27 August 2013 19:40, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Yes, better not to change what's already there if it works fine.
> > However, as I mentioned in my previous email, it's probably better to
> > have a convention here for new code rather than having people stick
> > these markers in random places within the declaration and hit the "it
> > silently doesn't work" case.
> 
>  init.h header file mentions the following about the attribute placement:
> 
>  For initialized data:
> * You should insert __initdata between the variable name and equal
> * sign followed by value, e.g.:
> *
> * static int init_variable __initdata = 0;
> * static const char linux_logo[] __initconst = { 0x32, 0x36, ... };

Yes, sure, but who reads that?

Not me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
