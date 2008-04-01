From: Anthony Liguori <anthony@codemonkey.ws>
Date: Tue, 01 Apr 2008 03:05:25 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] ibmaem: New driver for power/energy
Message-Id: <47F1A675.3050204@codemonkey.ws>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213805.GB7183@tree.beaverton.ibm.com>
In-Reply-To: <20080328213805.GB7183@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Darrick J. Wong wrote:
> New driver to read energy, power, and temperature meters in various
> IBM System X hardware.

<snip>

> +/* sysfs support functions */
> +/* Discover sensors on an AEM device */
> +#define AEM_FIND_SENSORS(type) \
> +static int type##_find_sensors(struct type##_data *data) \
> +{ \
> +	struct aem_ro_sensor_template *ro; \
> +	struct aem_rw_sensor_template *rw; \
> +	int err, idx; \
> +\
> +	/* Set up read-only sensors */ \
> +	ro = type##_ro_sensors; \
> +	idx = 0; \
> +	while (ro->label) { \
> +		data->sensors[idx].dev_attr.attr.name = ro->label; \
> +		data->sensors[idx].dev_attr.attr.mode = S_IRUGO; \
> +		data->sensors[idx].dev_attr.show = ro->show; \
> +		data->sensors[idx].index = ro->index; \
> +\
> +		err = device_create_file(&data->fw.pdev->dev, \
> +					 &data->sensors[idx].dev_attr); \
> +		if (err) { \
> +			data->sensors[idx].dev_attr.attr.name = NULL; \
> +			goto exit_remove; \
> +		} \
> +		idx++; \
> +		ro++; \
> +	} \
> +\
> +	/* Set up read-write sensors */ \
> +	rw = type##_rw_sensors; \
> +	while (rw->label) { \
> +		data->sensors[idx].dev_attr.attr.name = rw->label; \
> +		data->sensors[idx].dev_attr.attr.mode = S_IRUGO | S_IWUSR; \
> +		data->sensors[idx].dev_attr.show = rw->show; \
> +		data->sensors[idx].dev_attr.store = rw->set; \
> +		data->sensors[idx].index = rw->index; \
> +\
> +		err = device_create_file(&data->fw.pdev->dev, \
> +					 &data->sensors[idx].dev_attr); \
> +		if (err) { \
> +			data->sensors[idx].dev_attr.attr.name = NULL; \
> +			goto exit_remove; \
> +		} \
> +		idx++; \
> +		rw++; \
> +	} \
> +\
> +	err = device_create_file(&data->fw.pdev->dev, \
> +			&sensor_dev_attr_name.dev_attr); \
> +	if (err) \
> +		goto exit_remove; \
> +\
> +	return 0; \
> +\
> +exit_remove: \
> +	type##_remove_sensors(data); \
> +	return err; \
> +} 

It really shouldn't be necessary to have all of these macro functions. 
In this above macro, you would just have to pass the ro and rw 
structures along with a remove function pointer.  Since all of your 
types have common members, you could just have a common substructure and 
pass that around.

Regards,

Anthony Liguori

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
