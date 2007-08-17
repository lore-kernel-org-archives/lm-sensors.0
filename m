From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 17 Aug 2007 19:45:34 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] libsensors4: Support more bus types,
Message-Id: <46C5FADE.6000401@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171717.43f05611@hyperion.delvare>
In-Reply-To: <20070817171717.43f05611@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Support more bus types (part 2 of 2). Originally libsensors was very
> i2c-centric. Make it more neutral so that we can cleanly support
> additional bus types such as SPI or One-Wire.
> 
> This second part updates sensors_bus to use sensors_bus_id. Thanks
> to Mark M. Hoffman for showing me how the configuration file
> parser could be modified to support that change.
> 

Looks good to me, can you commit these to svn before the end of the weekend, 
monday I'll be back at work and there I have several machines to test with, so 
if you can get all your changes into svn before monday then I can give svn a 
good testing with various setups @ work.

Regards,

Hans



> ---
>  lib/access.c     |    3 ++-
>  lib/conf-parse.y |   14 +++++++-------
>  lib/data.c       |   15 ++++++++-------
>  lib/data.h       |    8 ++++----
>  lib/sysfs.c      |    5 +++--
>  5 files changed, 24 insertions(+), 21 deletions(-)
> 
> --- lm-sensors-3.orig/lib/conf-parse.y	2007-08-17 09:23:30.000000000 +0200
> +++ lm-sensors-3/lib/conf-parse.y	2007-08-17 10:54:59.000000000 +0200
> @@ -94,7 +94,7 @@ static sensors_chip *current_chip = NULL
>    void *nothing;
>    sensors_chip_name_list chips;
>    sensors_expr *expr;
> -  int bus;
> +  sensors_bus_id bus;
>    sensors_chip_name chip;
>    int line;
>  }  
> @@ -118,7 +118,7 @@ static sensors_chip *current_chip = NULL
>  
>  %type <chips> chip_name_list
>  %type <expr> expression
> -%type <bus> i2cbus_name
> +%type <bus> bus_id
>  %type <name> adapter_name
>  %type <name> function_name
>  %type <name> string
> @@ -141,10 +141,10 @@ line:	  bus_statement EOL
>  	| error	EOL
>  ;
>  
> -bus_statement:	  BUS i2cbus_name adapter_name
> +bus_statement:	  BUS bus_id adapter_name
>  		  { sensors_bus new_el;
>  		    new_el.lineno = $1;
> -                    new_el.number = $2;
> +		    new_el.bus = $2;
>                      new_el.adapter = $3;
>  		    bus_add_el(&new_el);
>  		  }
> @@ -287,11 +287,11 @@ expression:	  FLOAT	
>  		  }
>  ;
>  
> -i2cbus_name:	  NAME
> -		  { int res = sensors_parse_i2cbus_name($1,&$$);
> +bus_id:		  NAME
> +		  { int res = sensors_parse_bus_id($1,&$$);
>  		    free($1);
>  		    if (res) {
> -                      sensors_yyerror("Parse error in i2c bus name");
> +                      sensors_yyerror("Parse error in bus id");
>  		      YYERROR;
>                      }
>  		  }
> --- lm-sensors-3.orig/lib/data.c	2007-08-17 10:40:49.000000000 +0200
> +++ lm-sensors-3/lib/data.c	2007-08-17 10:57:54.000000000 +0200
> @@ -167,7 +167,7 @@ int sensors_snprintf_chip_name(char *str
>  	return -SENSORS_ERR_CHIP_NAME;
>  }
>  
> -int sensors_parse_i2cbus_name(const char *name, int *res)
> +int sensors_parse_bus_id(const char *name, sensors_bus_id *bus)
>  {
>  	char *endptr;
>  
> @@ -175,8 +175,9 @@ int sensors_parse_i2cbus_name(const char
>  		return -SENSORS_ERR_BUS_NAME;
>  	}
>  	name += 4;
> -	*res = strtoul(name, &endptr, 10);
> -	if (*name = '\0' || *endptr != '\0' || *res < 0)
> +	bus->type = SENSORS_BUS_TYPE_I2C;
> +	bus->nr = strtoul(name, &endptr, 10);
> +	if (*name = '\0' || *endptr != '\0' || bus->nr < 0)
>  		return -SENSORS_ERR_BUS_NAME;
>  	return 0;
>  }
> @@ -185,12 +186,12 @@ int sensors_substitute_chip(sensors_chip
>  {
>  	int i, j;
>  	for (i = 0; i < sensors_config_busses_count; i++)
> -		if (name->bus.type = SENSORS_BUS_TYPE_I2C &&
> -		    sensors_config_busses[i].number = name->bus.nr)
> +		if (sensors_config_busses[i].bus.type = name->bus.type &&
> +		    sensors_config_busses[i].bus.nr = name->bus.nr)
>  			break;
>  
>  	if (i = sensors_config_busses_count) {
> -		sensors_parse_error("Undeclared i2c bus referenced", lineno);
> +		sensors_parse_error("Undeclared bus id referenced", lineno);
>  		name->bus.nr = sensors_proc_bus_count;
>  		return -SENSORS_ERR_BUS_NAME;
>  	}
> @@ -199,7 +200,7 @@ int sensors_substitute_chip(sensors_chip
>  	for (j = 0; j < sensors_proc_bus_count; j++) {
>  		if (!strcmp(sensors_config_busses[i].adapter,
>  			    sensors_proc_bus[j].adapter)) {
> -			name->bus.nr = sensors_proc_bus[j].number;
> +			name->bus.nr = sensors_proc_bus[j].bus.nr;
>  			return 0;
>  		}
>  	}
> --- lm-sensors-3.orig/lib/data.h	2007-08-17 09:23:30.000000000 +0200
> +++ lm-sensors-3/lib/data.h	2007-08-17 10:53:33.000000000 +0200
> @@ -110,10 +110,10 @@ typedef struct sensors_chip {
>    int lineno;
>  } sensors_chip;
>  
> -/* Config file bus declaration: the i2c bus number, combined with adapter
> +/* Config file bus declaration: the bus type and number, combined with adapter
>     name */
>  typedef struct sensors_bus {
> -  int number;
> +  sensors_bus_id bus;
>    char *adapter;
>    int lineno;
>  } sensors_bus;
> @@ -175,8 +175,8 @@ extern int sensors_proc_bus_max;
>  int sensors_substitute_busses(void);
>  
>  
> -/* Parse an i2c bus name into its components. Returns 0 on succes, a value from
> +/* Parse a bus id into its components. Returns 0 on succes, a value from
>     error.h on failure. */
> -int sensors_parse_i2cbus_name(const char *name, int *res);
> +int sensors_parse_bus_id(const char *name, sensors_bus_id *bus);
>  
>  #endif /* def LIB_SENSORS_DATA_H */
> --- lm-sensors-3.orig/lib/access.c	2007-08-17 09:24:35.000000000 +0200
> +++ lm-sensors-3/lib/access.c	2007-08-17 10:53:33.000000000 +0200
> @@ -326,7 +326,8 @@ const char *sensors_get_adapter_name(con
>  
>  	/* bus types with several instances */
>  	for (i = 0; i < sensors_proc_bus_count; i++)
> -		if (sensors_proc_bus[i].number = bus->nr)
> +		if (sensors_proc_bus[i].bus.type = bus->type &&
> +		    sensors_proc_bus[i].bus.nr = bus->nr)
>  			return sensors_proc_bus[i].adapter;
>  	return NULL;
>  }
> --- lm-sensors-3.orig/lib/sysfs.c	2007-08-17 09:24:35.000000000 +0200
> +++ lm-sensors-3/lib/sysfs.c	2007-08-17 10:53:33.000000000 +0200
> @@ -380,9 +380,10 @@ int sensors_read_sysfs_bus(void)
>  		      (attr = sysfs_get_device_attr(dev, "name"))))
>  			continue;
>  
> -		if (sscanf(clsdev->name, "i2c-%d", &entry.number) != 1 ||
> -		    entry.number = 9191) /* legacy ISA */
> +		if (sscanf(clsdev->name, "i2c-%hd", &entry.bus.nr) != 1 ||
> +		    entry.bus.nr = 9191) /* legacy ISA */
>  			continue;
> +		entry.bus.type = SENSORS_BUS_TYPE_I2C;
>  
>  		/* NB: attr->value[attr->len-1] = '\n'; chop that off */
>  		entry.adapter = strndup(attr->value, attr->len - 1);
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
