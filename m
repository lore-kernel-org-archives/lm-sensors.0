From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 20 Nov 2012 03:41:08 +0000
Subject: Re: [lm-sensors] [PATCH 131/493] hwmon: remove use of __devexit_p
Message-Id: <20121120034108.GA27264@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1353349642-3677-131-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-131-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 19, 2012 at 01:21:20PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Hans de Goede <hdegoede@redhat.com> 
> Cc: Jean Delvare <khali@linux-fr.org> 
> Cc: Guenter Roeck <linux@roeck-us.net> 
> Cc: Alistair John Strachan <alistair@devzero.co.uk> 
> Cc: Fenghua Yu <fenghua.yu@intel.com> 
> Cc: Juerg Haefliger <juergh@gmail.com> 
> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com> 
> Cc: Clemens Ladisch <clemens@ladisch.de> 
> Cc: Rudolf Marek <r.marek@assembler.cz> 
> Cc: Jim Cromie <jim.cromie@gmail.com> 
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com> 
> Cc: Roger Lucas <vt8231@hiddenengine.co.uk> 
> Cc: lm-sensors@lm-sensors.org 
> Cc: patches@opensource.wolfsonmicro.com 

Acked-by: Guenter Roeck <linux@roeck-us.net>

What is the plan ? Should those patches be committed through hwmon
or through some other tree ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
