From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Apr 2012 23:36:15 +0000
Subject: Re: [lm-sensors] [PATCH 0/5] acpi_power_meter: clean up duplicate code
Message-Id: <1333582575.17982.44.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1333390501.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1333390501.git.kyle@mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-04-02 at 14:18 -0400, Kyle McMartin wrote:
> From: Kyle McMartin <kyle@mcmartin.ca>
> 
> acpi_power_meter currently duplicates a lot of code between the rw and
> ro sensor templates unnecessarily. The attached five part series cleans
> things up to use the same code path for both, deciding which is which by
> the use of the .set field.
> 
> Additionally, (imho at least) it makes the struct initializers a bit
> more pretty and uses a macro to reduce the repetition of each member.
> 
> It's been compile tested across the series for bisectability, but I do
> not currently have access to any device which uses this driver for
> testing.
> 
> regards, Kyle McMartin
> 
> Kyle McMartin (5):
>   acpi_power_meter: use the same struct {rw,ro}_sensor_template for
>     both
>   acpi_power_meter: use a {RW,RO}_SENSOR_TEMPLATE macro to clean things
>     up
>   acpi_power_meter: remove duplicate code between
>     register_{ro,rw}_attrs
>   acpi_power_meter: drop meter_rw_attrs, use common meter_attrs
>   acpi_power_meter: clean up code around setup_attrs
> 
>  drivers/hwmon/acpi_power_meter.c |  165 +++++++++++++++++---------------------
>  1 files changed, 72 insertions(+), 93 deletions(-)
> 
Series applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
