From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 23 Jan 2006 17:49:50 +0000
Subject: [lm-sensors] [PATCH] vt1211: Reading of temp1
Message-Id: <191fb4ca0601230949m14d3c5c6p7774d1ce5cb2055c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0601190913q4ac4079dw8be3bd609af7c60d@mail.gmail.com>
In-Reply-To: <191fb4ca0601190913q4ac4079dw8be3bd609af7c60d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

A couple of days ago I submitted the following patch but never saw a
response nor any comment/feedback at all. Is there anything else I
need to do to get this patch reviewed and accepted?

Thanks
...juerg


On 1/19/06, Juerg Haefliger <juergh at gmail.com> wrote:
> This patch enables the reading of temp1 (Reading3) from the VT1211.
> Reading3 returns the V1211's internal temperature.
>
> The patch has been compiled and tested on a VIA EPIA M10000 running
> kernel 2.4.32.
>
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> ---
> diff -urN lm_sensors-2.9.2.orig/kernel/chips/vt1211.c
> lm_sensors-2.9.2/kernel/chips/vt1211.c
> --- lm_sensors-2.9.2.orig/kernel/chips/vt1211.c Tue Sep  6 12:38:10 2005
> +++ lm_sensors-2.9.2/kernel/chips/vt1211.c      Thu Jan 19 08:54:39 2006
> @@ -99,8 +99,8 @@
>     changes from via686a.
>         Sensor          Voltage Mode    Temp Mode
>         --------        ------------    ---------
> -       Reading 1                       temp3
> -       Reading 3                       temp1   not in vt1211
> +       Reading 1                       temp3   Intel thermal diode
> +       Reading 3                       temp1   VT1211 internal thermal diode
>         UCH1/Reading2   in0             temp2
>         UCH2            in1             temp4
>         UCH3            in2             temp5
> @@ -249,7 +249,7 @@
>  #define VT1211_SYSCTL_IN6 1006
>  #define VT1211_SYSCTL_FAN1 1101
>  #define VT1211_SYSCTL_FAN2 1102
> -#define VT1211_SYSCTL_TEMP 1200
> +#define VT1211_SYSCTL_TEMP1 1200
>  #define VT1211_SYSCTL_TEMP2 1201
>  #define VT1211_SYSCTL_TEMP3 1202
>  #define VT1211_SYSCTL_TEMP4 1203
> @@ -268,7 +268,7 @@
>  #define VT1211_ALARM_IN2 0x02
>  #define VT1211_ALARM_IN5 0x04
>  #define VT1211_ALARM_IN3 0x08
> -#define VT1211_ALARM_TEMP 0x10
> +#define VT1211_ALARM_TEMP1 0x10
>  #define VT1211_ALARM_FAN1 0x40
>  #define VT1211_ALARM_FAN2 0x80
>  #define VT1211_ALARM_IN4 0x100
> @@ -277,7 +277,7 @@
>  #define VT1211_ALARM_CHAS 0x1000
>  #define VT1211_ALARM_TEMP3 0x8000
>  /* duplicates */
> -#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP
> +#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP2
>  #define VT1211_ALARM_TEMP4 VT1211_ALARM_IN1
>  #define VT1211_ALARM_TEMP5 VT1211_ALARM_IN2
>  #define VT1211_ALARM_TEMP6 VT1211_ALARM_IN3
> @@ -302,9 +302,9 @@
>      datasheet says these are reserved
>         {VT1211_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
>          &i2c_sysctl_real, NULL, &vt1211_in},
> -       {VT1211_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
> -        &i2c_sysctl_real, NULL, &vt1211_temp},
>  */
> +       {VT1211_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL,
> +        &i2c_proc_real, &i2c_sysctl_real, NULL, &vt1211_temp},
>         {VT1211_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL,
>          &i2c_proc_real, &i2c_sysctl_real, NULL, &vt1211_temp},
>         {VT1211_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL,
> @@ -513,7 +513,7 @@
>                         data->fan_min[i - 1] = vt_rdval(client,
>                                                      VT1211_REG_FAN_MIN(i));
>                 }
> -               for (i = 2; i <= 7; i++) {
> +               for (i = 1; i <= 7; i++) {
>                         if(ISTEMP(i, data->uch_config)) {
>                                 data->temp[i - 1] = vt_rdval(client,
>                                                      VT1211_REG_TEMP(i)) << 2;
> @@ -638,7 +638,7 @@
>                   int *nrels_mag, long *results)
>  {
>         struct vt1211_data *data = client->data;
> -       int nr = ctl_name - VT1211_SYSCTL_TEMP;
> +       int nr = ctl_name - VT1211_SYSCTL_TEMP1;
>
>         if (operation = SENSORS_PROC_REAL_INFO)
>                 *nrels_mag = 1;
> diff -urN lm_sensors-2.9.2.orig/lib/chips.c lm_sensors-2.9.2/lib/chips.c
> --- lm_sensors-2.9.2.orig/lib/chips.c   Tue Sep  6 12:38:10 2005
> +++ lm_sensors-2.9.2/lib/chips.c        Thu Jan 19 08:53:49 2006
> @@ -4536,7 +4536,14 @@
>      { SENSORS_VT1211_FAN2_MIN, "fan2_min", SENSORS_VT1211_FAN2,
>                               SENSORS_VT1211_FAN2,
>                               RW, VT1211_SYSCTL_FAN2, VALUE(1), 0 },
> -    /* no temp1 */
> +    { SENSORS_VT1211_TEMP1, "temp1", NOMAP, NOMAP,
> +                         R, VT1211_SYSCTL_TEMP1, VALUE(3), 1 },
> +    { SENSORS_VT1211_TEMP1_HYST, "temp1_hyst", SENSORS_VT1211_TEMP1,
> +                              SENSORS_VT1211_TEMP1, RW,
> +                              VT1211_SYSCTL_TEMP1, VALUE(2), 1 },
> +    { SENSORS_VT1211_TEMP1_OVER, "temp1_over", SENSORS_VT1211_TEMP1,
> +                              SENSORS_VT1211_TEMP1, RW,
> +                              VT1211_SYSCTL_TEMP1, VALUE(1), 1 },
>      { SENSORS_VT1211_TEMP2, "temp2", NOMAP, NOMAP,
>                           R, VT1211_SYSCTL_TEMP2, VALUE(3), 1 },
>      { SENSORS_VT1211_TEMP2_HYST, "temp2_hyst", SENSORS_VT1211_TEMP2,
> diff -urN lm_sensors-2.9.2.orig/lib/chips.h lm_sensors-2.9.2/lib/chips.h
> --- lm_sensors-2.9.2.orig/lib/chips.h   Tue Sep  6 12:38:10 2005
> +++ lm_sensors-2.9.2/lib/chips.h        Thu Jan 19 08:53:49 2006
> @@ -1708,9 +1708,9 @@
>  #define SENSORS_VT1211_FAN2 32 /* R */
>  #define SENSORS_VT1211_FAN1_MIN 41 /* RW */
>  #define SENSORS_VT1211_FAN2_MIN 42 /* RW */
> -#define SENSORS_VT1211_TEMP 51 /* R */
> -#define SENSORS_VT1211_TEMP_HYST 52 /* RW */
> -#define SENSORS_VT1211_TEMP_OVER 53 /* RW */
> +#define SENSORS_VT1211_TEMP1 51 /* R */
> +#define SENSORS_VT1211_TEMP1_HYST 52 /* RW */
> +#define SENSORS_VT1211_TEMP1_OVER 53 /* RW */
>  #define SENSORS_VT1211_TEMP2 54 /* R */
>  #define SENSORS_VT1211_TEMP2_HYST 55 /* RW */
>  #define SENSORS_VT1211_TEMP2_OVER 56 /* RW */
> diff -urN lm_sensors-2.9.2.orig/prog/sensors/chips.c
> lm_sensors-2.9.2/prog/sensors/chips.c
> --- lm_sensors-2.9.2.orig/prog/sensors/chips.c  Tue Sep  6 12:38:10 2005
> +++ lm_sensors-2.9.2/prog/sensors/chips.c       Thu Jan 19 08:53:49 2006
> @@ -4317,8 +4317,19 @@
>        printf("ERROR: Can't get FAN2 data!\n");
>    }
>    free_the_label(&label);
> -
> -  /* no temp 1 */
> +  if (sensors_get_label_and_valid(*name,SENSORS_VT1211_TEMP1,&label,&valid)) {
> +    printf("ERROR: Can't get TEMP1 config!\n");
> +  } else if (valid) {
> +    if(!(err = sensors_get_feature(*name,SENSORS_VT1211_TEMP1,&cur)) &&
> +       !(err = sensors_get_feature(*name,SENSORS_VT1211_TEMP1_HYST,&min)) &&
> +       !(err = sensors_get_feature(*name,SENSORS_VT1211_TEMP1_OVER,&max))) {
> +      print_label(label,10);
> +      print_temp_info( cur, max, min, HYST, 1, 0);
> +      printf(" %s\n", alarms & VT1211_ALARM_TEMP1 ? "ALARM" : "" );
> +    } else
> +      printf("ERROR: Can't get TEMP1 data!\n");
> +  }
> +  free_the_label(&label);
>    if (sensors_get_label_and_valid(*name,SENSORS_VT1211_TEMP2,&label,&valid)) {
>      printf("ERROR: Can't get TEMP2 config!\n");
>    } else if (valid) {
>

