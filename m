From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 08 Jan 2009 16:15:19 +0000
Subject: Re: [lm-sensors] [PATCH] ACPI: set acpi_enforce_resources to strict
Message-Id: <49662697.9080302@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090106182012.GA6668@dreamland.darkstar.lan>
In-Reply-To: <20090106182012.GA6668@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>



Luca Tettamanti wrote:
> The following patch changes the default for "acpi_enforce_resources" option to
> "strict", disallowing access by native drivers to IO ports and memory regions
> claimed by ACPI firmware.
> 

Hi Luca (et all)

I know it was me who proposed to send a mail about this to the ACPI list, but 
when I did I had an RFC mail in mind, not a patch.

I've been discussing this with Jean Delvare (he is back from his holliday), and 
he agrees that in the end this is the right thing to do. But this will probably 
stop the smbus controller drivers (Jean is the i2c subsystem maintainer) from 
loading on quite a few motherboards. Given that ACPI claims it is using these, 
this would actually be a good thing, but still it will probably make for a lot 
of unhappy users. So his call (and I support him there) is that it is too early 
to do that.

<Intermezzo to get those not involved in earlier discussion up to speed>

For those not familiar with the hwmon subsystem. Some (one or 2?) release ago a 
couple of new acpi functions were added:
acpi_check_resource_conflict()
acpi_check_region()
acpi_check_mem_region()

Which can be called by drivers to see if they are not trying to do IO to any 
ranges claimed by ACPI.

I did a full grep for these in 2.6.28, and they are only used by the smbus / 
i2c controller drivers there. In 2.6.29 the hwmon drivers for the hwmon part of 
superio IC's starts checking these too.

The behaviour of these 3 functions gets controlled by the global 
acpi_enforce_resources kernel (cmdline) option (and changing this from lax to 
strict will only influence these 3 methods). The default currently is lax, 
which will cause these methods to only issue a warning about conflicts, but not 
report any actual conflicts to the caller. Changing this to strict would 
actually report the conflict, stopping the smbus drivers (and hwmon superio) 
drivers from loading. As said before: Given that ACPI claims it is using these, 
this would actually be a good thing. But it is a change from current behaviour 
so quite some people will probably start yelling.

</intermezzo>

So back to the discussion about changing the default of acpi_enforce_resources 
to strict, Jean and I have been discussing this on IRC and we feel it will most 
likely cause too much pain. So we would like to suggest to make the default 
depend up on the motherboard. Our plan is to have the default be "auto" and 
that will mean "lax", unless the motherboard is atk0110 (Asus ACPI interface 
for reading hwmon data) capable and in that case "auto" will mean "strict"

The plan is then to merge this acpi subsystem change and the atk0110 driver at 
the same time, so that people will get different hwmon capabilities, but won't 
loose hwmon capabilities all together. Important note: this is meant as an 
temporary state of affairs, the end goal is to make the checking strict.

Luca do you think you could do a patch implementing the described "auto" value 
for acpi_enforce_resources ?

ACPI people, would this be acceptable as a temporary solution ?

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
