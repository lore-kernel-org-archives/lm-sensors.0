From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 17 Aug 2009 22:05:58 +0000
Subject: Re: [lm-sensors] [PATCH v2] acpi_power_meter: hwmon driver for ACPI
Message-Id: <20090817150558.3468426b.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com>
	<20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
	<alpine.LFD.2.00.0907272124110.4445@localhost.localdomain>
	<20090803205812.GC14694@plum>
	<20090806204255.GD14694@plum>
In-Reply-To: <20090806204255.GD14694@plum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 6 Aug 2009 13:42:57 -0700
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> This driver exposes ACPI 4.0 compliant power meters as hardware monitoring
> devices.  This second revision of the driver also exports the ACPI string
> info as sysfs attributes, a list of the devices that the meter measures,
> and will send ACPI notifications over the ACPI netlink socket.
> 
>
> ...
>
> +static ssize_t set_avg_interval(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { 1, &arg0 };
> +	int res;
> +	unsigned long temp;
> +	unsigned long long data;
> +	acpi_status status;
> +
> +	res = strict_strtoul(buf, 10, &temp);
> +	if (res)
> +		return res;
> +
> +	if (temp > resource->caps.max_avg_interval ||
> +	    temp < resource->caps.min_avg_interval)
> +		return -EINVAL;
> +	arg0.integer.value = temp;
> +
> +	mutex_lock(&resource->lock);
> +	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
> +				       &args, &data);
> +	if (!ACPI_FAILURE(status))
> +		resource->avg_interval = temp;
> +	mutex_unlock(&resource->lock);
> +
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PAI"));
> +		return -EINVAL;
> +	}
> +
> +	if (data)
> +		return -EINVAL;

I find this test of `data' inexplicable.  Is it just me, or do we need
a comment here?

> +	return count;
> +}
> +
>
> ...
>
> +static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
> +		       const char *buf, size_t count)
> +{
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { 1, &arg0 };
> +	int res;
> +	unsigned long temp;
> +	unsigned long long data;
> +	acpi_status status;
> +
> +	res = strict_strtoul(buf, 10, &temp);
> +	if (res)
> +		return res;
> +
> +	temp /= 1000;
> +	if (temp > resource->caps.max_cap || temp < resource->caps.min_cap)
> +		return -EINVAL;
> +	arg0.integer.value = temp;
> +
> +	mutex_lock(&resource->lock);
> +	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
> +				       &args, &data);
> +	if (!ACPI_FAILURE(status))
> +		resource->cap = temp;
> +	mutex_unlock(&resource->lock);
> +
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SHL"));
> +		return -EINVAL;
> +	}
> +
> +	if (data)
> +		return -EINVAL;

ditto.

> +	return count;
> +}
> +


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
