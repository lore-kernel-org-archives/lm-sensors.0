From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 02 Nov 2010 14:04:56 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <20101102140456.GB30009@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 02, 2010 at 09:21:02AM -0400, Jean Delvare wrote:
> Hi Fred,
> 
> Please don't top-post.
> 
> On Tue, 12 Oct 2010 09:15:03 +0200, Fred . wrote:
> > I am sorry tha I do not have the nescesary equipment nor skill set in
> > order to be able to help test
> > or contribute with code.
> > 
> > Now since the interface definition is upstreams, I hope that someone
> > may implement the feature
> > in at least one of the drivers.
> 
> This is done now: the new w83795 hardware monitoring driver implements
> the standard intrusion detection interface.
> 
> I have written user-space code to use that interface. I have two
> patches, one for libsensors, one for sensors, both apply on top of
> lm-sensors SVN, if anyone wants to give them a try. I've attached them.
> They work OK for me, I'll commit them soon unless someone finds and
> reports a problem with them.
> 
> Then we will have to convert the remaining drivers. I found 3 drivers
> which need to be converted: adm9240, w83792d and w83793. If there are
> more, please let me know.
> 
Reminds me. I have a set of patches for those almost ready for submission.
Hope you didn't do the same work ;).

Code below looks ok.

Guenter

> -- 
> Jean Delvare

> Add support for intrusion detection to libsensors.
> 
> ---
>  doc/libsensors-API.txt |    6 ++++++
>  lib/Module.mk          |    2 +-
>  lib/sensors.h          |    4 ++++
>  lib/sysfs.c            |   14 +++++++++++---
>  4 files changed, 22 insertions(+), 4 deletions(-)
> 
> --- lm-sensors.orig/lib/sensors.h	2010-11-02 12:59:04.000000000 +0100
> +++ lm-sensors/lib/sensors.h	2010-11-02 13:00:26.000000000 +0100
> @@ -141,6 +141,7 @@ typedef enum sensors_feature_type {
>  	SENSORS_FEATURE_ENERGY		= 0x04,
>  	SENSORS_FEATURE_CURR		= 0x05,
>  	SENSORS_FEATURE_VID		= 0x10,
> +	SENSORS_FEATURE_INTRUSION	= 0x11,
>  	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
>  	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
>  } sensors_feature_type;
> @@ -198,6 +199,9 @@ typedef enum sensors_subfeature_type {
>  
>  	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
>  
> +	SENSORS_SUBFEATURE_INTRUSION_ALARM = SENSORS_FEATURE_INTRUSION << 8,
> +	SENSORS_SUBFEATURE_INTRUSION_BEEP,
> +
>  	SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_BEEP_ENABLE << 8,
>  
>  	SENSORS_SUBFEATURE_UNKNOWN = INT_MAX,
> --- lm-sensors.orig/lib/sysfs.c	2010-11-02 12:59:04.000000000 +0100
> +++ lm-sensors/lib/sysfs.c	2010-11-02 13:00:26.000000000 +0100
> @@ -137,14 +137,14 @@ static int sysfs_foreach_busdev(const ch
>  char sensors_sysfs_mount[NAME_MAX];
>  
>  #define MAX_MAIN_SENSOR_TYPES	6
> -#define MAX_OTHER_SENSOR_TYPES	1
> +#define MAX_OTHER_SENSOR_TYPES	2
>  #define MAX_SENSORS_PER_TYPE	24
>  #define MAX_SUBFEATURES		8
>  #define FEATURE_SIZE		(MAX_SUBFEATURES * 2)
>  #define FEATURE_TYPE_SIZE	(MAX_SENSORS_PER_TYPE * FEATURE_SIZE)
>  
> -/* Room for all 6 main types (in, fan, temp, power, energy, current) and 1
> -   other type (VID) with all their subfeatures + misc features */
> +/* Room for all 6 main types (in, fan, temp, power, energy, current) and 2
> +   other types (VID, intrusion) with all their subfeatures + misc features */
>  #define SUB_OFFSET_OTHER	(MAX_MAIN_SENSOR_TYPES * FEATURE_TYPE_SIZE)
>  #define SUB_OFFSET_MISC		(SUB_OFFSET_OTHER + \
>  				 MAX_OTHER_SENSOR_TYPES * FEATURE_TYPE_SIZE)
> @@ -190,6 +190,7 @@ char *get_feature_name(sensors_feature_t
>  	case SENSORS_FEATURE_POWER:
>  	case SENSORS_FEATURE_ENERGY:
>  	case SENSORS_FEATURE_CURR:
> +	case SENSORS_FEATURE_INTRUSION:
>  		underscore = strchr(sfname, '_');
>  		name = strndup(sfname, underscore - sfname);
>  		if (!name)
> @@ -289,6 +290,11 @@ static const struct subfeature_type_matc
>  	{ NULL, 0 }
>  };
>  
> +static const struct subfeature_type_match intrusion_matches[] = {
> +	{ "alarm", SENSORS_SUBFEATURE_INTRUSION_ALARM },
> +	{ "beep", SENSORS_SUBFEATURE_INTRUSION_BEEP },
> +	{ NULL, 0 }
> +};
>  static struct feature_type_match matches[] = {
>  	{ "temp%d%c", temp_matches },
>  	{ "in%d%c", in_matches },
> @@ -297,6 +303,7 @@ static struct feature_type_match matches
>  	{ "power%d%c", power_matches },
>  	{ "curr%d%c", curr_matches },
>  	{ "energy%d%c", energy_matches },
> +	{ "intrusion%d%c", intrusion_matches },
>  };
>  
>  /* Return the subfeature type and channel number based on the subfeature
> @@ -411,6 +418,7 @@ static int sensors_read_dynamic_chip(sen
>  		   sorted table */
>  		switch (ftype) {
>  		case SENSORS_FEATURE_VID:
> +		case SENSORS_FEATURE_INTRUSION:
>  			i = SUB_OFFSET_OTHER +
>  			    (ftype - SENSORS_FEATURE_VID) * FEATURE_TYPE_SIZE +
>  			    nr * FEATURE_SIZE + (sftype & 0xFF);
> --- lm-sensors.orig/doc/libsensors-API.txt	2010-10-10 20:20:31.000000000 +0200
> +++ lm-sensors/doc/libsensors-API.txt	2010-11-02 13:01:58.000000000 +0100
> @@ -6,6 +6,12 @@ over time. This document summarizes thes
>  authors can quickly figure out how to test for the availability of a
>  given new feature.
>  
> +0x431	lm-sensors SVN
> +* Added support for intrusion detection
> +  enum sensors_feature_type SENSORS_FEATURE_INTRUSION
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_INTRUSION_ALARM
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_INTRUSION_BEEP
> +
>  0x430	lm-sensors 3.2.0
>  * License changed from GPL to LGPL
>  
> --- lm-sensors.orig/lib/Module.mk	2010-10-10 20:03:08.000000000 +0200
> +++ lm-sensors/lib/Module.mk	2010-11-02 13:02:18.000000000 +0100
> @@ -33,7 +33,7 @@ LIBMAN5FILES := $(MODULE_DIR)/sensors.co
>  # changed in a backward incompatible way.  The interface is defined by
>  # the public header files - in this case they are error.h and sensors.h.
>  LIBMAINVER := 4
> -LIBMINORVER := 3.0
> +LIBMINORVER := 3.1
>  LIBVER := $(LIBMAINVER).$(LIBMINORVER)
>  
>  # The static lib name, the shared lib name, and the internal ('so') name of

> Add support for intrusion detection to sensors.
> 
> ---
>  prog/sensors/chips.c |   26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> --- lm-sensors.orig/prog/sensors/chips.c	2010-11-02 13:37:40.000000000 +0100
> +++ lm-sensors/prog/sensors/chips.c	2010-11-02 13:38:10.000000000 +0100
> @@ -2,7 +2,7 @@
>      chips.c - Part of sensors, a user-space program for hardware monitoring
>      Copyright (C) 1998-2003  Frodo Looijaard <frodol@dds.nl> and
>                               Mark D. Studebaker <mdsxyz123@yahoo.com>
> -    Copyright (C) 2007       Jean Delvare <khali@linux-fr.org>
> +    Copyright (C) 2007-2010  Jean Delvare <khali@linux-fr.org>
>  
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
> @@ -661,6 +661,27 @@ static void print_chip_curr(const sensor
>  	printf("\n");
>  }
>  
> +static void print_chip_intrusion(const sensors_chip_name *name,
> +				 const sensors_feature *feature,
> +				 int label_size)
> +{
> +	char *label;
> +	const sensors_subfeature *subfeature;
> +	double alarm;
> +
> +	subfeature = sensors_get_subfeature(name, feature,
> +					    SENSORS_SUBFEATURE_INTRUSION_ALARM);
> +	if (!subfeature)
> +		return;
> +
> +	if ((label = sensors_get_label(name, feature))
> +	 && !sensors_get_value(name, subfeature->number, &alarm)) {
> +		print_label(label, label_size);
> +		printf("%s\n", alarm ? "ALARM" : "OK");
> +	}
> +	free(label);
> +}
> +
>  void print_chip(const sensors_chip_name *name)
>  {
>  	const sensors_feature *feature;
> @@ -695,6 +716,9 @@ void print_chip(const sensors_chip_name
>  		case SENSORS_FEATURE_CURR:
>  			print_chip_curr(name, feature, label_size);
>  			break;
> +		case SENSORS_FEATURE_INTRUSION:
> +			print_chip_intrusion(name, feature, label_size);
> +			break;
>  		default:
>  			continue;
>  		}


-- 
Guenter Roeck
Distinguished Engineer
PDU IP Systems

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
