From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: CVS patch for lm85 fixes and EMC6D100 support
Message-Id: <3ED7F4A9.4000107@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED78579.9030203@penguincomputing.com>
In-Reply-To: <3ED78579.9030203@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

checked in.
Had to add a couple of semicolons to get it to compile :)

Philip Pokorny wrote:
> This patch fixes a race condition in the lm85 driver and adds support 
> for the SMC EMC6D100 and EMC6D101.  The EMC6D100 and 101 chips have some 
> additional features that *are not* currently implemented in the driver, 
> but the chip is detected (by sensors-detect and the lm85 driver).
> 
> :v)
> 
> 
> ------------------------------------------------------------------------
> 
> ? lm_sensors2/kernel/chips/.lm85.c.swp
> ? lm_sensors2/kernel/include/create_sensors_h.pl
> Index: lm_sensors2/doc/chips/lm85
> =================================> RCS file: /home/cvs/lm_sensors2/doc/chips/lm85,v
> retrieving revision 1.1
> diff -u -r1.1 lm85
> --- lm_sensors2/doc/chips/lm85	17 Mar 2003 02:34:09 -0000	1.1
> +++ lm_sensors2/doc/chips/lm85	30 May 2003 16:27:41 -0000
> @@ -503,9 +503,9 @@
>     set in2_min  3.3 * 0.95
>     set in2_max  3.3 * 1.05
>     set in3_min  5.0 * 0.95
> -   set in4_max  5.0 * 1.05
> +   set in3_max  5.0 * 1.05
>     set in4_min   12 * 0.95
> -   set in3_max   12 * 1.05
> +   set in4_max   12 * 1.05
>  
>  # Set Fan limits
>     set fan1_min  3000
> Index: lm_sensors2/kernel/chips/lm85.c
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/chips/lm85.c,v
> retrieving revision 1.3
> diff -u -r1.3 lm85.c
> --- lm_sensors2/kernel/chips/lm85.c	17 Mar 2003 03:13:28 -0000	1.3
> +++ lm_sensors2/kernel/chips/lm85.c	30 May 2003 16:27:41 -0000
> @@ -1,4 +1,3 @@
> -#define DEBUG 1
>  /*
>      lm85.c - Part of lm_sensors, Linux kernel modules for hardware
>               monitoring
> @@ -52,6 +51,7 @@
>      2003-03-08   Fixed problem with pseudo 16-bit registers
>                   Cleaned up some compiler warnings.
>                   Fixed problem with Operating Point and THERM counting
> +    2003-03-21   Initial support for EMC6D100 and EMC6D101 chips
>  */
>  
>  #include <linux/version.h>
> @@ -80,7 +80,7 @@
>  static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
>  
>  /* Insmod parameters */
> -SENSORS_INSMOD_4(lm85b, lm85c, adm1027, adt7463);
> +SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d101);
>  
>  /* Many LM85 constants specified below */
>  
> @@ -112,6 +112,7 @@
>  #define LM85_DEVICE_ADX 0x27
>  #define LM85_COMPANY_NATIONAL 0x01
>  #define LM85_COMPANY_ANALOG_DEV 0x41
> +#define LM85_COMPANY_SMSC 0x5c
>  #define LM85_VERSTEP_GENERIC 0x60
>  #define LM85_VERSTEP_LM85C 0x60
>  #define LM85_VERSTEP_LM85B 0x62
> @@ -351,15 +352,9 @@
>  #define LM85_DATA_INTERVAL  (1 * HZ)
>  #define LM85_CONFIG_INTERVAL  (5 * 60 * HZ)
>  
> -/* There are some complications in a module like this.  There might be
> -   several LM85 chips available (well, actually, that is probably never
> -   done; but it is a clean illustration of how to handle a case like
> -   that). */
> -
>  /* For each registered LM85, we need to keep some data in memory. That
> -   data is pointed to by lm85_list[NR]->data. The structure itself is
> -   dynamically allocated, at the same time when a new lm85 client is
> -   allocated. */
> +   data is pointed to by client->data. The structure itself is
> +   dynamically allocated, when a new lm85 client is allocated. */
>  
>  /* LM85 can automatically adjust fan speeds based on temperature
>   * This structure encapsulates an entire Zone config.  There are
> @@ -773,6 +768,11 @@
>  			printk("lm85: Unrecgonized version/stepping 0x%02x"
>  			    " Defaulting to ADM1027.\n", verstep );
>  			kind = adm1027 ;
> +		} else if( company = LM85_COMPANY_SMSC
> +		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
> +			printk("lm85: Your EMC6D10x has version/stepping 0x%02x"
> +			    " Please notify lm_sensors team.\n", verstep );
> +			kind = emc6d101 ;
>  		} else if( kind = 0 && (verstep & 0xf0) = 0x60) {
>  			printk("lm85: Generic LM85 Version 6 detected\n");
>  			/* Leave kind as "any_chip" */
> @@ -824,6 +824,16 @@
>  		memcpy( template+template_used, adm1027_specific, sizeof(adm1027_specific) );
>  		template_used += CTLTBL_ADM1027 ;
>  		break ;
> +	case emc6d100 :
> +		type_name = "emc6d100"
> +		strcpy(new_client->name, "SMSC EMC6D100");
> +		template_used = 0 ;
> +		break ;
> +	case emc6d101 :
> +		type_name = "emc6d101"
> +		strcpy(new_client->name, "SMSC EMC6D101");
> +		template_used = 0 ;
> +		break ;
>  	default :
>  		printk("lm85: Internal error, invalid kind (%d)!", kind);
>  		err = -EFAULT ;
> @@ -832,13 +842,11 @@
>  
>  	/* Fill in the remaining client fields */
>  	new_client->id = lm85_id++;
> -#ifdef DEBUG
>  	printk("lm85: Assigning ID %d to %s at %d,0x%02x\n",
>  		new_client->id, new_client->name,
>  		i2c_adapter_id(new_client->adapter),
>  		new_client->addr
>  	    );
> -#endif
>  
>  	/* Housekeeping values */
>  	data->type = kind;
> @@ -1076,7 +1084,7 @@
>  			break ;
>  		default :
>  			data->extend_adc = 0 ;
> -                        break ;
> +			break ;
>  		}
>  
>  		for (i = 0; i <= 4; ++i) {
> @@ -1250,6 +1258,7 @@
>  		results[2] = INSEXT_FROM_REG(nr,data->in[nr],ext);
>  		*nrels_mag = 3;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 1) {
>  			data->in_max[nr] = INS_TO_REG(nr,results[1]);
>  			lm85_write_value(client, LM85_REG_IN_MAX(nr),
> @@ -1260,6 +1269,7 @@
>  			lm85_write_value(client, LM85_REG_IN_MIN(nr),
>  					 data->in_min[nr]);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1280,11 +1290,13 @@
>  		results[1] = FAN_FROM_REG(data->fan[nr]);
>  		*nrels_mag = 2;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 0) {
>  			data->fan_min[nr] = FAN_TO_REG(results[0]);
>  			lm85_write_value(client, LM85_REG_FAN_MIN(nr),
>  					 data->fan_min[nr]);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1312,6 +1324,7 @@
>  		results[2] = TEMPEXT_FROM_REG(data->temp[nr],ext);
>  		*nrels_mag = 3;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 1) {
>  			data->temp_max[nr] = TEMP_TO_REG(results[1]);
>  			lm85_write_value(client, LM85_REG_TEMP_MAX(nr),
> @@ -1322,6 +1335,7 @@
>  			lm85_write_value(client, LM85_REG_TEMP_MIN(nr),
>  					 data->temp_min[nr]);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1345,12 +1359,14 @@
>  		results[1] = pwm_zone != 0 && pwm_zone != -1 ;
>  		*nrels_mag = 2;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		/* PWM enable is read-only */
>  		if (*nrels_mag > 0) {
>  			data->pwm[nr] = PWM_TO_REG(results[0]);
>  			lm85_write_value(client, LM85_REG_PWM(nr),
>  					 data->pwm[nr]);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1385,9 +1401,11 @@
>  		results[0] = data->vrm ;
>  		*nrels_mag = 1;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 0) {
>  			data->vrm = results[0] ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1426,6 +1444,7 @@
>  		results[2] = (data->spinup_ctl & 4) != 0 ;
>  		*nrels_mag = 3;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		old = data->spinup_ctl ;
>  		if (*nrels_mag > 2) {
>  			old = (old & (~4)) | (results[2]?4:0) ;
> @@ -1438,6 +1457,7 @@
>  			lm85_write_value(client, LM85_REG_SPINUP_CTL, old);
>  			data->spinup_ctl = old ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1461,6 +1481,7 @@
>  		results[2] = (data->tach_mode & 0x30) >> 4 ;
>  		*nrels_mag = 3;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		old = data->tach_mode ;
>  		if (*nrels_mag > 2) {
>  			old = (old & (~0x30)) | ((results[2]&3) << 4) ;
> @@ -1473,6 +1494,7 @@
>  			lm85_write_value(client, LM85_REG_TACH_MODE, old);
>  			data->tach_mode = old ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1497,6 +1519,7 @@
>  		results[3] = (data->tach_mode & 0x80) != 0 ;
>  		*nrels_mag = 4;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		old = data->tach_mode ;
>  		if (*nrels_mag > 3) {
>  			old = (old & (~0x80)) | (results[3] ? 0x80 : 0) ;
> @@ -1516,6 +1539,7 @@
>  			lm85_write_value(client, ADM1027_REG_CONFIG3, old);
>  			data->tach_mode = old ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1542,6 +1566,7 @@
>  		results[4] = (data->autofan[nr].config & 0x10) ? 10 : 0 ;
>  		*nrels_mag = 5;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		int  old_config ;
>  		old_config = data->autofan[nr].config ;
>  		if (*nrels_mag > 4) {
> @@ -1575,6 +1600,7 @@
>  			lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr), old_config);
>  			data->autofan[nr].config = old_config ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1595,6 +1621,7 @@
>  		*nrels_mag = 1;
>  
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if( *nrels_mag > 0 ) {
>  			data->smooth[nr] = SMOOTH_TO_REG(results[0]);
>  		}
> @@ -1610,6 +1637,7 @@
>  		    lm85_write_value(client, LM85_REG_AFAN_SPIKE2,
>  			(data->smooth[1] << 4) | data->smooth[2]);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1636,6 +1664,7 @@
>  		*nrels_mag = 4;
>  
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 3) {
>  			data->zone[nr].critical = TEMP_TO_REG(results[3]*10);
>  			lm85_write_value(client, LM85_REG_AFAN_CRITICAL(nr),
> @@ -1667,6 +1696,7 @@
>  			    data->zone[nr].limit
>  			);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1686,6 +1716,7 @@
>  		results[0] = ZONE_FROM_REG(data->autofan[nr].config);
>  		*nrels_mag = 1;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 0) {
>  			data->autofan[nr].config >  			    (data->autofan[nr].config & (~0xe0))
> @@ -1693,6 +1724,7 @@
>  			lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
>  			    data->autofan[nr].config);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1720,6 +1752,7 @@
>  		}
>  		*nrels_mag = 1;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 0) {
>  			switch( data->type ) {
>  			case adm1027 :
> @@ -1733,6 +1766,7 @@
>  			lm85_write_value(client, ADM1027_REG_TEMP_OFFSET(nr),
>  			    data->temp_offset[nr]);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1755,6 +1789,7 @@
>  		results[3] = PPR_FROM_REG(data->fan_ppr,3);
>  		*nrels_mag = 4;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		old = data->fan_ppr ;
>  		if (*nrels_mag > 3) {
>  			old = (old & ~PPR_MASK(3)) | PPR_TO_REG(results[3],3);
> @@ -1770,6 +1805,7 @@
>  			lm85_write_value(client, ADM1027_REG_FAN_PPR, old);
>  			data->fan_ppr = old ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1788,11 +1824,13 @@
>  		results[0] = INTMASK_FROM_REG(data->alarm_mask);
>  		*nrels_mag = 1;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		if (*nrels_mag > 0) {
>  			data->alarm_mask = INTMASK_TO_REG(results[0]);
>  			lm85_write_value(client, ADM1027_REG_INTMASK,
>  			    data->alarm_mask);
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1816,6 +1854,7 @@
>  		results[3] = OPPOINT_FROM_REG(data->oppoint[nr]);
>  		*nrels_mag = 4;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		old = data->tmin_ctl ;
>  		if (*nrels_mag > 3) {
>  			data->oppoint[nr] = OPPOINT_TO_REG(results[3]);
> @@ -1842,6 +1881,7 @@
>  			lm85_write_value(client, ADT7463_REG_TMIN_CTL, old);
>  			data->tmin_ctl = old ;
>  		}
> +		up(&data->update_lock);
>  	}
>  }
>  
> @@ -1876,18 +1916,21 @@
>  		results[2] = data->therm_ovfl ;
>  		*nrels_mag = 3;
>  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
> +		down(&data->update_lock);
>  		/* therm_total and therm_ovfl are read only */
>  		if (*nrels_mag > 0) {
>  			data->therm_limit = SENSORS_LIMIT(results[0],0,255);
>  			lm85_write_value(client, ADT7463_REG_THERM_LIMIT,
>  			    data->therm_limit);
>  		};
> +		up(&data->update_lock);
>  	}
>  }
>  
>  static int __init sm_lm85_init(void)
>  {
>  	printk("lm85 version %s (%s)\n", LM_VERSION, LM_DATE);
> +	printk("lm85: See http://www.penguincomputing.com/lm_sensors for more info.\n" );
>  	return i2c_add_driver(&lm85_driver);
>  }
>  
> Index: lm_sensors2/prog/detect/sensors-detect
> =================================> RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
> retrieving revision 1.203
> diff -u -r1.203 sensors-detect
> --- lm_sensors2/prog/detect/sensors-detect	17 Mar 2003 02:34:10 -0000	1.203
> +++ lm_sensors2/prog/detect/sensors-detect	30 May 2003 16:27:42 -0000
> @@ -805,6 +805,12 @@
>         i2c_detect => sub { lm85_detect 0x41, @_},
>       },
>       {
> +       name => "SMSC EMC6D100 and EMC6D101",
> +       driver => "lm85",
> +       i2c_addrs => [0x2c..0x2e],
> +       i2c_detect => sub { lm85_detect 0x5c, @_},
> +     },
> +     {
>         name => "National Semiconductor LM87",
>         driver => "lm87",
>         i2c_addrs => [0x2c..0x2e],
> @@ -2234,6 +2240,7 @@
>  #		  0x3f = Version/Stepping register.
>  # Constants used: 0x01 = National Semiconductor Vendor Id.
>  #                 0x41 = Analog Devices Vendor Id.
> +#                 0x5c = SMSC Vendor Id.
>  #		  0x60 = Version number. The lower 4 stepping
>  #			  bits are masked and ignored.
>  sub lm85_detect
> Index: lm_sensors2/prog/sensors/chips.c
> =================================> RCS file: /home/cvs/lm_sensors2/prog/sensors/chips.c,v
> retrieving revision 1.80
> diff -u -r1.80 chips.c
> --- lm_sensors2/prog/sensors/chips.c	17 Mar 2003 02:34:10 -0000	1.80
> +++ lm_sensors2/prog/sensors/chips.c	30 May 2003 16:27:43 -0000
> @@ -1488,11 +1488,15 @@
>      alarms = 0;
>    }
>  
> -  if (!sensors_get_feature(*name,SENSORS_ADM1027_ALARM_MASK,&cur)) 
> -    alarm_mask = cur + 0.5;
> -  else {
> -    printf("ERROR: Can't get alarm mask data!\n");
> -    alarm_mask = 0;
> +  if( is1027 ) {
> +    if (!sensors_get_feature(*name,SENSORS_ADM1027_ALARM_MASK,&cur)) 
> +      alarm_mask = cur + 0.5;
> +    else {
> +      printf("ERROR: Can't get alarm mask data!\n");
> +      alarm_mask = 0;
> +    }
> +  } else {
> +    alarm_mask = 0 ;
>    }
>  
>    if (!sensors_get_label_and_valid(*name,SENSORS_LM85_IN0,&label,&valid) &&
