From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 17 Aug 2007 19:44:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <46C5FAB2.6060001@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Support more bus types (part 1 of 2). Originally libsensors was very
> i2c-centric. Make it more neutral so that we can cleanly support
> additional bus types such as SPI or One-Wire.
> 
> This first part introduces sensors_bus_id, and updates
> sensors_chip_name to use it.
> 

Looks good to me, can you commit these to svn before the end of the weekend, 
monday I'll be back at work and there I have several machines to test with, so 
if you can get all your changes into svn before monday then I can give svn a 
good testing with various setups @ work.

Regards,

Hans

> ---
>  lib/access.c        |   43 +++++++++++++++++------------------
>  lib/data.c          |   62 +++++++++++++++++++++++++++++----------------------
>  lib/sensors.h       |   22 ++++++++++++------
>  lib/sysfs.c         |   24 ++++++++++++-------
>  prog/sensord/args.c |    3 +-
>  prog/sensors/main.c |    7 +++--
>  6 files changed, 93 insertions(+), 68 deletions(-)
> 
> --- lm-sensors-3.orig/lib/sensors.h	2007-08-17 09:23:31.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2007-08-17 09:24:35.000000000 +0200
> @@ -1,6 +1,7 @@
>  /*
>      sensors.h - Part of libsensors, a Linux library for reading sensor data.
>      Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
> +    Copyright (C) 2007        Jean Delvare <khali@linux-fr.org>
>  
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
> @@ -26,22 +27,29 @@
>  /* Publicly accessible library functions */
>  
>  #define SENSORS_CHIP_NAME_PREFIX_ANY NULL
> -#define SENSORS_CHIP_NAME_BUS_ISA -1
> -#define SENSORS_CHIP_NAME_BUS_ANY -2
> -#define SENSORS_CHIP_NAME_BUS_ANY_I2C -3
> -#define SENSORS_CHIP_NAME_BUS_PCI -5
>  #define SENSORS_CHIP_NAME_ADDR_ANY -1
>  
> +#define SENSORS_BUS_TYPE_ANY	(-1)
> +#define SENSORS_BUS_TYPE_I2C	0
> +#define SENSORS_BUS_TYPE_ISA	1
> +#define SENSORS_BUS_TYPE_PCI	2
> +#define SENSORS_BUS_NR_ANY	(-1)
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif /* __cplusplus */
>  
>  extern const char *libsensors_version;
>  
> +typedef struct sensors_bus_id {
> +	short type;
> +	short nr;
> +} sensors_bus_id;
> +
>  /* A chip name is encoded in this structure */
>  typedef struct sensors_chip_name {
>  	char *prefix;
> -	int bus;
> +	sensors_bus_id bus;
>  	int addr;
>  	char *path;
>  } sensors_chip_name;
> @@ -70,10 +78,10 @@ int sensors_snprintf_chip_name(char *str
>  int sensors_match_chip(const sensors_chip_name *chip1,
>  		       const sensors_chip_name *chip2);
>  
> -/* This function returns the adapter name of a bus number,
> +/* This function returns the adapter name of a bus,
>     as used within the sensors_chip_name structure. If it could not be found,
>     it returns NULL */
> -const char *sensors_get_adapter_name(int bus_nr);
> +const char *sensors_get_adapter_name(const sensors_bus_id *bus);
>  
>  /* Look up the label which belongs to this chip. Note that chip should not
>     contain wildcard values! *result is newly allocated (free it yourself).
> --- lm-sensors-3.orig/lib/data.c	2007-08-17 09:23:31.000000000 +0200
> +++ lm-sensors-3/lib/data.c	2007-08-17 10:40:49.000000000 +0200
> @@ -92,7 +92,8 @@ int sensors_parse_chip_name(const char *
>  	/* Then we have either a sole "*" (all chips with this name) or a bus
>  	   type and an address. */
>  	if (!strcmp(name, "*")) {
> -		res->bus = SENSORS_CHIP_NAME_BUS_ANY;
> +		res->bus.type = SENSORS_BUS_TYPE_ANY;
> +		res->bus.nr = SENSORS_BUS_NR_ANY;
>  		res->addr = SENSORS_CHIP_NAME_ADDR_ANY;
>  		return 0;
>  	}
> @@ -100,11 +101,11 @@ int sensors_parse_chip_name(const char *
>  	if (!(dash = strchr(name, '-')))
>  		goto ERROR;
>  	if (!strncmp(name, "i2c", dash - name))
> -		res->bus = SENSORS_CHIP_NAME_BUS_ANY_I2C;
> +		res->bus.type = SENSORS_BUS_TYPE_I2C;
>  	else if (!strncmp(name, "isa", dash - name))
> -		res->bus = SENSORS_CHIP_NAME_BUS_ISA;
> +		res->bus.type = SENSORS_BUS_TYPE_ISA;
>  	else if (!strncmp(name, "pci", dash - name))
> -		res->bus = SENSORS_CHIP_NAME_BUS_PCI;
> +		res->bus.type = SENSORS_BUS_TYPE_PCI;
>  	else
>  		goto ERROR;
>  	name = dash + 1;
> @@ -112,17 +113,21 @@ int sensors_parse_chip_name(const char *
>  	/* Some bus types (i2c) have an additional bus number. For these, the
>  	   next part is either a "*" (any bus of that type) or a decimal
>  	   number. */
> -	switch (res->bus) {
> -	case SENSORS_CHIP_NAME_BUS_ANY_I2C:
> +	switch (res->bus.type) {
> +	case SENSORS_BUS_TYPE_I2C:
>  		if (!strncmp(name, "*-", 2)) {
> +			res->bus.nr = SENSORS_BUS_NR_ANY;
>  			name += 2;
>  			break;
>  		}
>  
> -		res->bus = strtoul(name, &dash, 10);
> -		if (*name = '\0' || *dash != '-' || res->bus < 0)
> +		res->bus.nr = strtoul(name, &dash, 10);
> +		if (*name = '\0' || *dash != '-' || res->bus.nr < 0)
>  			goto ERROR;
>  		name = dash + 1;
> +		break;
> +	default:
> +		res->bus.nr = SENSORS_BUS_NR_ANY;
>  	}
>  
>  	/* Last part is the chip address, or "*" for any address. */
> @@ -147,17 +152,19 @@ int sensors_snprintf_chip_name(char *str
>  	if (sensors_chip_name_has_wildcards(chip))
>  		return -SENSORS_ERR_WILDCARDS;
>  
> -	switch (chip->bus) {
> -	case SENSORS_CHIP_NAME_BUS_ISA:
> +	switch (chip->bus.type) {
> +	case SENSORS_BUS_TYPE_ISA:
>  		return snprintf(str, size, "%s-isa-%04x", chip->prefix,
>  				chip->addr);
> -	case SENSORS_CHIP_NAME_BUS_PCI:
> +	case SENSORS_BUS_TYPE_PCI:
>  		return snprintf(str, size, "%s-pci-%04x", chip->prefix,
>  				chip->addr);
> -	default:
> -		return snprintf(str, size, "%s-i2c-%d-%02x", chip->prefix,
> -				chip->bus, chip->addr);
> +	case SENSORS_BUS_TYPE_I2C:
> +		return snprintf(str, size, "%s-i2c-%hd-%02x", chip->prefix,
> +				chip->bus.nr, chip->addr);
>  	}
> +
> +	return -SENSORS_ERR_CHIP_NAME;
>  }
>  
>  int sensors_parse_i2cbus_name(const char *name, int *res)
> @@ -178,12 +185,13 @@ int sensors_substitute_chip(sensors_chip
>  {
>  	int i, j;
>  	for (i = 0; i < sensors_config_busses_count; i++)
> -		if (sensors_config_busses[i].number = name->bus)
> +		if (name->bus.type = SENSORS_BUS_TYPE_I2C &&
> +		    sensors_config_busses[i].number = name->bus.nr)
>  			break;
>  
>  	if (i = sensors_config_busses_count) {
>  		sensors_parse_error("Undeclared i2c bus referenced", lineno);
> -		name->bus = sensors_proc_bus_count;
> +		name->bus.nr = sensors_proc_bus_count;
>  		return -SENSORS_ERR_BUS_NAME;
>  	}
>  
> @@ -191,14 +199,14 @@ int sensors_substitute_chip(sensors_chip
>  	for (j = 0; j < sensors_proc_bus_count; j++) {
>  		if (!strcmp(sensors_config_busses[i].adapter,
>  			    sensors_proc_bus[j].adapter)) {
> -			name->bus = sensors_proc_bus[j].number;
> +			name->bus.nr = sensors_proc_bus[j].number;
>  			return 0;
>  		}
>  	}
>  
>  	/* We did not find anything. sensors_proc_bus_count is not
>  	   a valid bus number, so it will never be matched. Good. */
> -	name->bus = sensors_proc_bus_count;
> +	name->bus.nr = sensors_proc_bus_count;
>  	return 0;
>  }
>  
> @@ -211,14 +219,16 @@ int sensors_substitute_busses(void)
>  	for (i = 0; i < sensors_config_chips_count; i++) {
>  		lineno = sensors_config_chips[i].lineno;
>  		chips = &sensors_config_chips[i].chips;
> -		for (j = 0; j < chips->fits_count; j++)
> -			if (chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_ISA &&
> -			    chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_PCI &&
> -			    chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_ANY &&
> -			    chips->fits[j].bus != SENSORS_CHIP_NAME_BUS_ANY_I2C)
> -				if ((err = sensors_substitute_chip(chips->fits+j,
> -								   lineno)))
> -					res = err;
> +		for (j = 0; j < chips->fits_count; j++) {
> +			/* We can only substitute if a specific bus number
> +			   is given. */
> +			if (chips->fits[j].bus.nr = SENSORS_BUS_NR_ANY)
> +				continue;
> +
> +			err = sensors_substitute_chip(&chips->fits[j], lineno);
> +			if (err)
> +				res = err;
> +		}
>  	}
>  	return res;
>  }
> --- lm-sensors-3.orig/lib/access.c	2007-08-17 09:23:31.000000000 +0200
> +++ lm-sensors-3/lib/access.c	2007-08-17 09:24:35.000000000 +0200
> @@ -1,6 +1,7 @@
>  /*
>      access.c - Part of libsensors, a Linux library for reading sensor data.
>      Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
> +    Copyright (C) 2007        Jean Delvare <khali@linux-fr.org>
>  
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
> @@ -41,22 +42,15 @@ int sensors_match_chip(const sensors_chi
>  	    strcasecmp(chip1->prefix, chip2->prefix))
>  		return 0;
>  
> -	if ((chip1->bus != SENSORS_CHIP_NAME_BUS_ANY) &&
> -	    (chip2->bus != SENSORS_CHIP_NAME_BUS_ANY) &&
> -	    (chip1->bus != chip2->bus)) {
> -
> -		if ((chip1->bus = SENSORS_CHIP_NAME_BUS_ISA) ||
> -		    (chip2->bus = SENSORS_CHIP_NAME_BUS_ISA))
> -			return 0;
> -
> -		if ((chip1->bus = SENSORS_CHIP_NAME_BUS_PCI) ||
> -		    (chip2->bus = SENSORS_CHIP_NAME_BUS_PCI))
> -			return 0;
> -
> -		if ((chip1->bus != SENSORS_CHIP_NAME_BUS_ANY_I2C) &&
> -		    (chip2->bus != SENSORS_CHIP_NAME_BUS_ANY_I2C))
> -			return 0;
> -	}
> +	if ((chip1->bus.type != SENSORS_BUS_TYPE_ANY) &&
> +	    (chip2->bus.type != SENSORS_BUS_TYPE_ANY) &&
> +	    (chip1->bus.type != chip2->bus.type))
> +		return 0;
> +
> +	if ((chip1->bus.nr != SENSORS_BUS_NR_ANY) &&
> +	    (chip2->bus.nr != SENSORS_BUS_NR_ANY) &&
> +	    (chip1->bus.nr != chip2->bus.nr))
> +		return 0;
>  
>  	if ((chip1->addr != chip2->addr) &&
>  	    (chip1->addr != SENSORS_CHIP_NAME_ADDR_ANY) &&
> @@ -136,8 +130,8 @@ sensors_lookup_feature_name(const sensor
>  int sensors_chip_name_has_wildcards(const sensors_chip_name *chip)
>  {
>  	if ((chip->prefix = SENSORS_CHIP_NAME_PREFIX_ANY) ||
> -	    (chip->bus = SENSORS_CHIP_NAME_BUS_ANY) ||
> -	    (chip->bus = SENSORS_CHIP_NAME_BUS_ANY_I2C) ||
> +	    (chip->bus.type = SENSORS_BUS_TYPE_ANY) ||
> +	    (chip->bus.nr = SENSORS_BUS_NR_ANY) ||
>  	    (chip->addr = SENSORS_CHIP_NAME_ADDR_ANY))
>  		return 1;
>  	else
> @@ -318,16 +312,21 @@ const sensors_chip_name *sensors_get_det
>  	return res;
>  }
>  
> -const char *sensors_get_adapter_name(int bus_nr)
> +const char *sensors_get_adapter_name(const sensors_bus_id *bus)
>  {
>  	int i;
>  
> -	if (bus_nr = SENSORS_CHIP_NAME_BUS_ISA)
> +	/* bus types with a single instance */
> +	switch (bus->type) {
> +	case SENSORS_BUS_TYPE_ISA:
>  		return "ISA adapter";
> -	if (bus_nr = SENSORS_CHIP_NAME_BUS_PCI)
> +	case SENSORS_BUS_TYPE_PCI:
>  		return "PCI adapter";
> +	}
> +
> +	/* bus types with several instances */
>  	for (i = 0; i < sensors_proc_bus_count; i++)
> -		if (sensors_proc_bus[i].number = bus_nr)
> +		if (sensors_proc_bus[i].number = bus->nr)
>  			return sensors_proc_bus[i].adapter;
>  	return NULL;
>  }
> --- lm-sensors-3.orig/lib/sysfs.c	2007-08-17 09:23:31.000000000 +0200
> +++ lm-sensors-3/lib/sysfs.c	2007-08-17 09:24:35.000000000 +0200
> @@ -226,14 +226,16 @@ static int sensors_read_one_sysfs_chip(s
>  	if (!entry.chip.path)
>  		sensors_fatal_error(__FUNCTION__, "out of memory");
>  
> -	if (sscanf(dev->name, "%d-%x", &entry.chip.bus, &entry.chip.addr) = 2) {
> +	if (sscanf(dev->name, "%hd-%x", &entry.chip.bus.nr, &entry.chip.addr) = 2) {
>  		/* find out if legacy ISA or not */
> -		if (entry.chip.bus = 9191)
> -			entry.chip.bus = SENSORS_CHIP_NAME_BUS_ISA;
> -		else {
> +		if (entry.chip.bus.nr = 9191) {
> +			entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
> +			entry.chip.bus.nr = 0;
> +		} else {
> +			entry.chip.bus.type = SENSORS_BUS_TYPE_I2C;
>  			snprintf(bus_path, sizeof(bus_path),
>  				"%s/class/i2c-adapter/i2c-%d/device/name",
> -				sensors_sysfs_mount, entry.chip.bus);
> +				sensors_sysfs_mount, entry.chip.bus.nr);
>  
>  			if ((bus_attr = sysfs_open_attribute(bus_path))) {
>  				if (sysfs_read_attribute(bus_attr)) {
> @@ -242,19 +244,23 @@ static int sensors_read_one_sysfs_chip(s
>  				}
>  
>  				if (bus_attr->value
> -				 && !strncmp(bus_attr->value, "ISA ", 4))
> -					entry.chip.bus = SENSORS_CHIP_NAME_BUS_ISA;
> +				 && !strncmp(bus_attr->value, "ISA ", 4)) {
> +					entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
> +					entry.chip.bus.nr = 0;
> +				}
>  
>  				sysfs_close_attribute(bus_attr);
>  			}
>  		}
>  	} else if (sscanf(dev->name, "%*[a-z0-9_].%d", &entry.chip.addr) = 1) {
>  		/* must be new ISA (platform driver) */
> -		entry.chip.bus = SENSORS_CHIP_NAME_BUS_ISA;
> +		entry.chip.bus.type = SENSORS_BUS_TYPE_ISA;
> +		entry.chip.bus.nr = 0;
>  	} else if (sscanf(dev->name, "%x:%x:%x.%x", &domain, &bus, &slot, &fn) = 4) {
>  		/* PCI */
>  		entry.chip.addr = (domain << 16) + (bus << 8) + (slot << 3) + fn;
> -		entry.chip.bus = SENSORS_CHIP_NAME_BUS_PCI;
> +		entry.chip.bus.type = SENSORS_BUS_TYPE_PCI;
> +		entry.chip.bus.nr = 0;
>  	} else
>  		goto exit_free;
>  	
> --- lm-sensors-3.orig/prog/sensord/args.c	2007-08-17 09:23:31.000000000 +0200
> +++ lm-sensors-3/prog/sensord/args.c	2007-08-17 09:24:35.000000000 +0200
> @@ -288,7 +288,8 @@ parseChips
>  (int argc, char **argv) {
>    if (optind = argc) {
>      chipNames[0].prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
> -    chipNames[0].bus = SENSORS_CHIP_NAME_BUS_ANY;
> +    chipNames[0].bus.type = SENSORS_BUS_TYPE_ANY;
> +    chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
>      chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
>      numChipNames = 1;
>    } else {
> --- lm-sensors-3.orig/prog/sensors/main.c	2007-08-17 09:23:31.000000000 +0200
> +++ lm-sensors-3/prog/sensors/main.c	2007-08-17 09:24:35.000000000 +0200
> @@ -209,7 +209,8 @@ int main (int argc, char *argv[])
>  
>    if (optind = argc) {
>      chips[0].prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
> -    chips[0].bus = SENSORS_CHIP_NAME_BUS_ANY;
> +    chips[0].bus.type = SENSORS_BUS_TYPE_ANY;
> +    chips[0].bus.nr = SENSORS_BUS_NR_ANY;
>      chips[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
>      chips_count = 1;
>    } else 
> @@ -310,11 +311,11 @@ void do_a_print(const sensors_chip_name 
>  
>    printf("%s\n",sprintf_chip_name(name));
>    if (!hide_adapter) {
> -    const char *adap = sensors_get_adapter_name(name->bus);
> +    const char *adap = sensors_get_adapter_name(&name->bus);
>      if (adap)
>        printf("Adapter: %s\n", adap);
>      else
> -      fprintf(stderr, "Can't get adapter name for bus %d\n", name->bus);
> +      fprintf(stderr, "Can't get adapter name\n");
>    }
>    if (do_unknown)
>      print_unknown_chip(name);
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
