From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 03 Apr 2012 15:39:18 +0000
Subject: Re: [lm-sensors] [PATCH 0/5] acpi_power_meter: clean up duplicate code
Message-Id: <20120403153918.GA10741@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1333390501.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1333390501.git.kyle@mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 02, 2012 at 02:18:59PM -0400, Kyle McMartin wrote:
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
Hi Kyle,

nice cleanup series.

Couple of comments / questions. That won't prevent me from applying the series, just some things
to think about.

- You could have used a single macro instead of two, with _set set to NULL for read-only attributes.
- Why not just use SENSOR_DEVICE_ATTR, struct attribute, and sysfs_create_group/sysfs_remove_group ?
- I think there may be a race condition in acpi_power_meter_notify(), in the METER_NOTIFY_CONFIG path.
  It frees some data, re-allocates it, then removes the attributes and re-creates them. If someone
  were to read the power1_model_number attribute after the call to free_capabilities, show_str()
  might potentially access freed memory.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
