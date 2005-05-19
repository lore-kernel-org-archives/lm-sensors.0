From: robertj@myfamilyinc.com (Robert Jackson)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Bug in lm_sensors-2.8.6 for lm75
Message-Id: <3B7A491B88659F4FA3578A728CDC8896015F1455@pr-ex1.corp.myfamilyinc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In reference to ticket #1647

I found that the sensors binary was looking for temp1_hyst, but in the
source temp_hyst is referenced for LM75.  Here are the changes I made to
make it work.


------------------------------------------------------------------------
------------------

diff -cbr lm_sensors-2.8.6/doc/chips/lm75
lm_sensors-2.8.6-patch/doc/chips/lm75
*** lm_sensors-2.8.6/doc/chips/lm75	2002-09-12 19:20:32.000000000
-0600
--- lm_sensors-2.8.6-patch/doc/chips/lm75	2004-04-08
10:29:00.000000000 -0600
***************
*** 87,98 ****
  Chip `lm75'
            LABEL     LABEL CLASS   COMPUTE CLASS ACCESS MAGNITUDE
             temp            NONE            NONE      R     1
!       temp_hyst            temp            temp      RW    1
        temp_over            temp            temp      RW    1
  
            LABEL                           FEATURE SYMBOL     SYSCTL
FILE:OFFSET
             temp                        SENSORS_LM75_TEMP
temp:3
!       temp_hyst                   SENSORS_LM75_TEMP_HYST
temp:2
        temp_over                   SENSORS_LM75_TEMP_OVER
temp:1
  
  
--- 87,98 ----
  Chip `lm75'
            LABEL     LABEL CLASS   COMPUTE CLASS ACCESS MAGNITUDE
             temp            NONE            NONE      R     1
!       temp1_hyst            temp            temp      RW    1
        temp_over            temp            temp      RW    1
  
            LABEL                           FEATURE SYMBOL     SYSCTL
FILE:OFFSET
             temp                        SENSORS_LM75_TEMP
temp:3
!       temp1_hyst                   SENSORS_LM75_TEMP1_HYST
temp:2
        temp_over                   SENSORS_LM75_TEMP_OVER
temp:1
  
  
diff -cbr lm_sensors-2.8.6/kernel/chips/lm75.c
lm_sensors-2.8.6-patch/kernel/chips/lm75.c
*** lm_sensors-2.8.6/kernel/chips/lm75.c	2003-12-01
22:53:27.000000000 -0700
--- lm_sensors-2.8.6-patch/kernel/chips/lm75.c	2004-04-08
10:28:33.000000000 -0600
***************
*** 40,46 ****
  /* The LM75 registers */
  #define LM75_REG_TEMP 0x00
  #define LM75_REG_CONF 0x01
! #define LM75_REG_TEMP_HYST 0x02
  #define LM75_REG_TEMP_OS 0x03
  
  /* Each client has this additional data */
--- 40,46 ----
  /* The LM75 registers */
  #define LM75_REG_TEMP 0x00
  #define LM75_REG_CONF 0x01
! #define LM75_REG_TEMP1_HYST 0x02
  #define LM75_REG_TEMP_OS 0x03
  
  /* Each client has this additional data */
***************
*** 51,57 ****
  	char valid;		/* !=0 if following fields are valid */
  	unsigned long last_updated;	/* In jiffies */
  
! 	u16 temp, temp_os, temp_hyst;	/* Register values */
  };
  
  static int lm75_attach_adapter(struct i2c_adapter *adapter);
--- 51,57 ----
  	char valid;		/* !=0 if following fields are valid */
  	unsigned long last_updated;	/* In jiffies */
  
! 	u16 temp, temp_os, temp1_hyst;	/* Register values */
  };
  
  static int lm75_attach_adapter(struct i2c_adapter *adapter);
***************
*** 264,271 ****
  
  		data->temp = lm75_read_value(client, LM75_REG_TEMP);
  		data->temp_os = lm75_read_value(client,
LM75_REG_TEMP_OS);
! 		data->temp_hyst ! 		    lm75_read_value(client, LM75_REG_TEMP_HYST);
  		data->last_updated = jiffies;
  		data->valid = 1;
  	}
--- 264,271 ----
  
  		data->temp = lm75_read_value(client, LM75_REG_TEMP);
  		data->temp_os = lm75_read_value(client,
LM75_REG_TEMP_OS);
! 		data->temp1_hyst ! 		    lm75_read_value(client, LM75_REG_TEMP1_HYST);
  		data->last_updated = jiffies;
  		data->valid = 1;
  	}
***************
*** 283,289 ****
  	else if (operation = SENSORS_PROC_REAL_READ) {
  		lm75_update_client(client);
  		results[0] = LM75_TEMP_FROM_REG(data->temp_os);
! 		results[1] = LM75_TEMP_FROM_REG(data->temp_hyst);
  		results[2] = LM75_TEMP_FROM_REG(data->temp);
  		*nrels_mag = 3;
  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
--- 283,289 ----
  	else if (operation = SENSORS_PROC_REAL_READ) {
  		lm75_update_client(client);
  		results[0] = LM75_TEMP_FROM_REG(data->temp_os);
! 		results[1] = LM75_TEMP_FROM_REG(data->temp1_hyst);
  		results[2] = LM75_TEMP_FROM_REG(data->temp);
  		*nrels_mag = 3;
  	} else if (operation = SENSORS_PROC_REAL_WRITE) {
***************
*** 293,301 ****
  					 data->temp_os);
  		}
  		if (*nrels_mag >= 2) {
! 			data->temp_hyst = LM75_TEMP_TO_REG(results[1]);
! 			lm75_write_value(client, LM75_REG_TEMP_HYST,
! 					 data->temp_hyst);
  		}
  	}
  }
--- 293,301 ----
  					 data->temp_os);
  		}
  		if (*nrels_mag >= 2) {
! 			data->temp1_hyst = LM75_TEMP_TO_REG(results[1]);
! 			lm75_write_value(client, LM75_REG_TEMP1_HYST,
! 					 data->temp1_hyst);
  		}
  	}
  }
diff -cbr lm_sensors-2.8.6/lib/chips.c
lm_sensors-2.8.6-patch/lib/chips.c
*** lm_sensors-2.8.6/lib/chips.c	2004-03-31 11:58:05.000000000
-0700
--- lm_sensors-2.8.6-patch/lib/chips.c	2004-04-08 10:23:02.000000000
-0600
***************
*** 292,298 ****
    {
      { SENSORS_LM75_TEMP, "temp", NOMAP, NOMAP,
                           R, LM75_SYSCTL_TEMP, VALUE(3), 1 },
!     { SENSORS_LM75_TEMP_HYST, "temp_hyst", SENSORS_LM75_TEMP,
                                SENSORS_LM75_TEMP, RW, 
                                LM75_SYSCTL_TEMP, VALUE(2), 1 },
      { SENSORS_LM75_TEMP_OVER, "temp_over", SENSORS_LM75_TEMP,
--- 292,298 ----
    {
      { SENSORS_LM75_TEMP, "temp", NOMAP, NOMAP,
                           R, LM75_SYSCTL_TEMP, VALUE(3), 1 },
!     { SENSORS_LM75_TEMP1_HYST, "temp_hyst", SENSORS_LM75_TEMP,
                                SENSORS_LM75_TEMP, RW, 
                                LM75_SYSCTL_TEMP, VALUE(2), 1 },
      { SENSORS_LM75_TEMP_OVER, "temp_over", SENSORS_LM75_TEMP, diff
-cbr lm_sensors-2.8.6/lib/chips.h lm_sensors-2.8.6-patch/lib/chips.h
*** lm_sensors-2.8.6/lib/chips.h	2004-03-31 11:58:05.000000000
-0700
--- lm_sensors-2.8.6-patch/lib/chips.h	2004-04-08 10:22:19.000000000
-0600
***************
*** 163,169 ****
  #define SENSORS_LM75_PREFIX "lm75"
  
  #define SENSORS_LM75_TEMP 51 /* R */
! #define SENSORS_LM75_TEMP_HYST 52 /* RW */
  #define SENSORS_LM75_TEMP_OVER 53 /* RW */
  
  /* ADM1021 chips. */
--- 163,169 ----
  #define SENSORS_LM75_PREFIX "lm75"
  
  #define SENSORS_LM75_TEMP 51 /* R */
! #define SENSORS_LM75_TEMP1_HYST 52 /* RW */
  #define SENSORS_LM75_TEMP_OVER 53 /* RW */
  
  /* ADM1021 chips. */
Only in lm_sensors-2.8.6: patch-lm_sensors-2.8.6.patch Only in
lm_sensors-2.8.6: patch-lm_sensors-2.8.6.patch2 diff -cbr
lm_sensors-2.8.6/prog/sensord/chips.c
lm_sensors-2.8.6-patch/prog/sensord/chips.c
*** lm_sensors-2.8.6/prog/sensord/chips.c	2004-03-21
03:35:49.000000000 -0700
--- lm_sensors-2.8.6-patch/prog/sensord/chips.c	2004-04-08
10:23:59.000000000 -0600
***************
*** 206,212 ****
  
  static const FeatureDescriptor lm75_features[] = {
    { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
!     { SENSORS_LM75_TEMP, SENSORS_LM75_TEMP_OVER,
SENSORS_LM75_TEMP_HYST, -1 } },
    { NULL }
  };
  
--- 206,212 ----
  
  static const FeatureDescriptor lm75_features[] = {
    { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
!     { SENSORS_LM75_TEMP, SENSORS_LM75_TEMP_OVER,
SENSORS_LM75_TEMP1_HYST, -1 } },
    { NULL }
  };
  
diff -cbr lm_sensors-2.8.6/prog/sensors/chips.c
lm_sensors-2.8.6-patch/prog/sensors/chips.c
*** lm_sensors-2.8.6/prog/sensors/chips.c	2004-03-31
11:58:05.000000000 -0700
--- lm_sensors-2.8.6-patch/prog/sensors/chips.c	2004-04-08
10:13:54.000000000 -0600
***************
*** 163,169 ****
  
    if
(!sensors_get_label_and_valid(*name,SENSORS_LM75_TEMP,&label,&valid) &&
        !sensors_get_feature(*name,SENSORS_LM75_TEMP,&cur) &&
!       !sensors_get_feature(*name,SENSORS_LM75_TEMP_HYST,&hyst) &&
        !sensors_get_feature(*name,SENSORS_LM75_TEMP_OVER,&over))  {
      if (valid) {
        print_label(label,10);
--- 163,169 ----
  
    if
(!sensors_get_label_and_valid(*name,SENSORS_LM75_TEMP,&label,&valid) &&
        !sensors_get_feature(*name,SENSORS_LM75_TEMP,&cur) &&
!       !sensors_get_feature(*name,SENSORS_LM75_TEMP1_HYST,&hyst) &&
        !sensors_get_feature(*name,SENSORS_LM75_TEMP_OVER,&over))  {
      if (valid) {
        print_label(label,10);


