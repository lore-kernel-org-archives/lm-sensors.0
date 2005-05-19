From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: CVS write access -- diffs included
Message-Id: <3D8CEFA9.CADC43AB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020920172403.A12232@mookie.cis.brown.edu>
In-Reply-To: <20020920172403.A12232@mookie.cis.brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks very much for the diffs.
All look good to me and are checked in, with the exception of the
dmidecode changes, which you included without comment.

The code &= ~0x80 changes are obviously correct.
However, dmidecode is maintained by Alan Cox - we just have a copy for
our uses.
Our dmidecode person ("Khali") is currently unavailable to push this to
Alan. You may wish
to forward your patch directly to Alan with comments.

thanks again
mds


Dave Johnson wrote:
> 
> On Fri, Sep 20, 2002 at 10:38:17AM -0700, phil@netroedge.com wrote:
> >
> > For this first round, could you send a diff?  I'd be happy to review
> > it and submit it for you.  Then, I will ask to have you added to the
> > cvs writers list.  Thanks in advance for the help with the coding!
> >
> >
> > Phil
> >
> > On Fri, Sep 20, 2002 at 01:26:22PM -0400, Dave Johnson wrote:
> > > I have made some improvements and a couple bug fixes in the lm_sensors2
> > > sources, and would like to contribute them to the codebase.
> > >
> > > The main change was to implement vrm settings other than 8.2 for the lm87
> > > module.  This is the chip used on Supermicro's P4LDR and possibly other
> > > motherboards.  Another change was to fix the W83781D_INIT_IN_[01] macros,
> > > to account for the fact that vid is now scaled by 1000 rather than 100.
> > >
> > > Also I modified the library chips.c to separate out the adm1023 from
> > > the others, since it scales remote_temp values by 1000.
> > >
> > > I could send you diffs, but I've been using cvs for nearly 10 years
> > > now, and it would be easier for me to just check them in.
> > >
> > > As a username, I'd prefer "ddj"...  the password hash is
> > >
> > > [snip!]
> > >
> > > Thanks,
> > >
> > >     -- ddj
> > >
> > >     Dave Johnson
> > >     ddj@cascv.brown.edu
> > >     Brown University TCASCV
> > >     (401) 863-7294
> >
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> Index: Makefile
> =================================> RCS file: /home/cvs/lm_sensors2/Makefile,v
> retrieving revision 1.55
> diff -u -2 -r1.55 Makefile
> --- Makefile    2002/04/29 01:37:07     1.55
> +++ Makefile    2002/09/20 21:30:32
> @@ -29,5 +29,6 @@
>  # The location of linux itself. This is used to find the kernel headers
>  # and other things.
> -LINUX=/usr/src/linux
> +#LINUX=/usr/src/linux
> +LINUX=/lib/modules/$(shell uname -r)/build
>  LINUX_HEADERS=$(LINUX)/include
> 
> Index: kernel/chips/lm87.c
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/chips/lm87.c,v
> retrieving revision 1.29
> diff -u -2 -r1.29 lm87.c
> --- kernel/chips/lm87.c 2002/02/09 22:36:26     1.29
> +++ kernel/chips/lm87.c 2002/09/20 21:30:33
> @@ -35,4 +35,5 @@
>  #include "version.h"
>  #include "sensors.h"
> +#include "sensors_vid.h"
>  #include <linux/init.h>
> 
> @@ -205,7 +206,4 @@
>  #define DIV_TO_REG(val) ((val)=1?0:((val)=8?3:((val)=4?2:1)))
> 
> -#define VID_FROM_REG(val) ((val)=0x1f?0:(val)>=0x10?510-(val)*10:\
> -                           205-(val)*5)
> -
>  #define LM87_INIT_FAN_MIN 3000
> 
> @@ -259,4 +257,5 @@
>         u8  analog_out;         /* Register value */
>         u8  vid;                /* Register value combined */
> +       u8  vrm;                /* VRM version * 10 */
>  };
> 
> @@ -304,4 +303,6 @@
>  static void lm87_vid(struct i2c_client *client, int operation,
>                         int ctl_name, int *nrels_mag, long *results);
> +static void lm87_vrm(struct i2c_client *client, int operation,
> +                       int ctl_name, int *nrels_mag, long *results);
> 
>  /* I choose here for semi-static LM87 allocation. Complete dynamic
> @@ -383,4 +384,6 @@
>         {LM87_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
>           &i2c_sysctl_real, NULL, &lm87_vid},
> +       {LM87_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
> +        &i2c_sysctl_real, NULL, &lm87_vrm},
>         {0}
>  };
> @@ -537,4 +540,5 @@
>  void lm87_init_client(struct i2c_client *client)
>  {
> +       struct lm87_data *data = client->data;
>         int vid;
>         u8 v;
> @@ -598,9 +602,11 @@
>                     | ((lm87_read_value(client, LM87_REG_VID4) & 0x01)
>                      << 4 );
> -       vid = VID_FROM_REG(v);
> -       v = vid * 95 * 192 / 27000;
> +       data->vrm = DEFAULT_VRM;
> +       vid = vid_from_reg(v, data->vrm);
> +
> +       v = vid * 95 * 192 / 270000;
>         lm87_write_value(client, LM87_REG_IN_MIN(1), v);
>         lm87_write_value(client, LM87_REG_IN_MIN(5), v);
> -       v = vid * 105 * 192 / 27000;
> +       v = vid * 105 * 192 / 270000;
>         lm87_write_value(client, LM87_REG_IN_MAX(1), v);
>         lm87_write_value(client, LM87_REG_IN_MAX(5), v);
> @@ -1013,9 +1019,24 @@
> 
>         if (operation = SENSORS_PROC_REAL_INFO)
> -               *nrels_mag = 2;
> +               *nrels_mag = 3;
>         else if (operation = SENSORS_PROC_REAL_READ) {
>                 lm87_update_client(client);
> -               results[0] = VID_FROM_REG(data->vid);
> -        *nrels_mag = 1;
> +               results[0] = vid_from_reg(data->vid, data->vrm);
> +               *nrels_mag = 1;
> +       }
> +}
> +
> +void lm87_vrm(struct i2c_client *client, int operation, int ctl_name,
> +                int *nrels_mag, long *results)
> +{
> +       struct lm87_data *data = client->data;
> +       if (operation = SENSORS_PROC_REAL_INFO)
> +               *nrels_mag = 1;
> +       else if (operation = SENSORS_PROC_REAL_READ) {
> +               results[0] = data->vrm;
> +               *nrels_mag = 1;
> +       } else if (operation = SENSORS_PROC_REAL_WRITE) {
> +               if (*nrels_mag >= 1)
> +                       data->vrm = results[0];
>         }
>  }
> Index: kernel/chips/w83781d.c
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/chips/w83781d.c,v
> retrieving revision 1.94
> diff -u -2 -r1.94 w83781d.c
> --- kernel/chips/w83781d.c      2002/08/04 19:01:35     1.94
> +++ kernel/chips/w83781d.c      2002/09/20 21:30:36
> @@ -218,6 +218,6 @@
> 
>  /* Initial limits */
> -#define W83781D_INIT_IN_0 (vid=350?280:vid)
> -#define W83781D_INIT_IN_1 (vid=350?280:vid)
> +#define W83781D_INIT_IN_0 (vid=3500?280:vid/10)
> +#define W83781D_INIT_IN_1 (vid=3500?280:vid/10)
>  #define W83781D_INIT_IN_2 330
>  #define W83781D_INIT_IN_3 (((500)   * 100)/168)
> Index: kernel/include/sensors.h
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/include/sensors.h,v
> retrieving revision 1.95
> diff -u -2 -r1.95 sensors.h
> --- kernel/include/sensors.h    2002/08/22 02:15:07     1.95
> +++ kernel/include/sensors.h    2002/09/20 21:30:37
> @@ -70,5 +70,5 @@
>  #define W83781D_SYSCTL_TEMP2 1201      /* Degrees Celcius * 10 */
>  #define W83781D_SYSCTL_TEMP3 1202      /* Degrees Celcius * 10 */
> -#define W83781D_SYSCTL_VID 1300        /* Volts * 100 */
> +#define W83781D_SYSCTL_VID 1300                /* Volts * 1000 */
>  #define W83781D_SYSCTL_VRM 1301
>  #define W83781D_SYSCTL_PWM1 1401
> @@ -415,4 +415,5 @@
>  #define LM87_SYSCTL_ANALOG_OUT 2002
>  #define LM87_SYSCTL_VID        2003
> +#define LM87_SYSCTL_VRM        2004
> 
>  #define LM87_ALARM_IN0          0x0001
> Index: lib/chips.c
> =================================> RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
> retrieving revision 1.72
> diff -u -2 -r1.72 chips.c
> --- lib/chips.c 2002/09/18 19:17:29     1.72
> +++ lib/chips.c 2002/09/20 21:30:39
> @@ -330,4 +330,32 @@
>    };
> 
> +static sensors_chip_feature adm1023_features[] > +  {
> +    { SENSORS_ADM1021_TEMP, "temp", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
> +                              SENSORS_MODE_R, ADM1021_SYSCTL_TEMP, VALUE(3),
> +                              0 },
> +    { SENSORS_ADM1021_TEMP_HYST, "temp_low", SENSORS_ADM1021_TEMP,
> +                              SENSORS_ADM1021_TEMP, SENSORS_MODE_RW,
> +                              ADM1021_SYSCTL_TEMP, VALUE(2), 0 },
> +    { SENSORS_ADM1021_TEMP_OVER, "temp_over", SENSORS_ADM1021_TEMP,
> +                              SENSORS_ADM1021_TEMP, SENSORS_MODE_RW,
> +                              ADM1021_SYSCTL_TEMP, VALUE(1), 0 },
> +    { SENSORS_ADM1021_REMOTE_TEMP, "remote_temp", SENSORS_NO_MAPPING,
> +                              SENSORS_NO_MAPPING, SENSORS_MODE_R,
> +                              ADM1021_SYSCTL_REMOTE_TEMP, VALUE(4), 3 },
> +    { SENSORS_ADM1021_REMOTE_TEMP_HYST, "remote_temp_low",
> +                              SENSORS_ADM1021_REMOTE_TEMP,
> +                              SENSORS_ADM1021_REMOTE_TEMP, SENSORS_MODE_RW,
> +                              ADM1021_SYSCTL_REMOTE_TEMP, VALUE(2), 3 },
> +    { SENSORS_ADM1021_REMOTE_TEMP_OVER, "remote_temp_over",
> +                              SENSORS_ADM1021_REMOTE_TEMP,
> +                              SENSORS_ADM1021_REMOTE_TEMP, SENSORS_MODE_RW,
> +                              ADM1021_SYSCTL_REMOTE_TEMP, VALUE(1), 3 },
> +    { SENSORS_ADM1021_ALARMS, "alarms", SENSORS_NO_MAPPING,
> +                              SENSORS_NO_MAPPING, SENSORS_MODE_R,
> +                              ADM1021_SYSCTL_ALARMS, VALUE(1), 0 },
> +    { 0 }
> +  };
> +
>  static sensors_chip_feature max1617_features[] >    {
> @@ -2137,5 +2165,7 @@
>                           LM87_SYSCTL_TEMP3, VALUE(1), 1 },
>      { SENSORS_LM87_VID, "vid", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
> -                         SENSORS_MODE_R, LM87_SYSCTL_VID, VALUE(1), 2 },
> +                         SENSORS_MODE_R, LM87_SYSCTL_VID, VALUE(1), 3 },
> +    { SENSORS_LM87_VRM, "vrm", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
> +                         SENSORS_MODE_RW, LM87_SYSCTL_VRM, VALUE(1), 1 },
>  /* Ho hum, this will be wrong if fan1 is disabled, but fan2 isn't.. fix?? */
>      { SENSORS_LM87_FAN1_DIV, "fan1_div", SENSORS_LM87_FAN1,
> @@ -3001,7 +3031,7 @@
>                 /* Cheat on GL523 for now - no separate #defines */
>   { SENSORS_GL523_PREFIX, adm1021_features },
> + { SENSORS_ADM1023_PREFIX, adm1023_features },
> -               /* Cheat on 1023,THMC10 for now - no separate #defines */
> - { SENSORS_ADM1023_PREFIX, adm1021_features },
> +               /* Cheat on THMC10 for now - no separate #defines */
>   { SENSORS_THMC10_PREFIX, adm1021_features },
>   { SENSORS_SIS5595_PREFIX, sis5595_features },
>   { SENSORS_MAXI_CG_PREFIX, maxi_cg_features },
> Index: lib/chips.h
> =================================> RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
> retrieving revision 1.58
> diff -u -2 -r1.58 chips.h
> --- lib/chips.h 2002/09/18 19:17:29     1.58
> +++ lib/chips.h 2002/09/20 21:30:39
> @@ -872,4 +872,5 @@
>  #define SENSORS_LM87_TEMP3_OVER      59 /* RW */
>  #define SENSORS_LM87_VID             61 /* R */
> +#define SENSORS_LM87_VRM             62 /* RW */
>  #define SENSORS_LM87_FAN1_DIV        71 /* RW */
>  #define SENSORS_LM87_FAN2_DIV        72 /* RW */
> Index: prog/detect/dmidecode.c
> =================================> RCS file: /home/cvs/lm_sensors2/prog/detect/dmidecode.c,v
> retrieving revision 1.4
> diff -u -2 -r1.4 dmidecode.c
> --- prog/detect/dmidecode.c     2002/08/10 15:34:22     1.4
> +++ prog/detect/dmidecode.c     2002/09/20 21:30:40
> @@ -189,7 +189,7 @@
>         };
> 
> -       if(num<=0x12)
> +       if(num<=0x11)
>                 return bus[num];
> -       if(num>=0xA0 && num<0xA5)
> +       if(num>=0xA0 && num<=0xA4)
>                 return jpbus[num - 0xA0];
>         return "";
> @@ -402,5 +402,5 @@
>                 return "Other";
> 
> -       if (code > 0xA1)
> +       if (code > 6)
>                 return "";
>         return processor_type[code];
> @@ -459,5 +459,5 @@
>                 "Sound",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code > 7)
>                 return "";
> @@ -483,5 +483,5 @@
>                 "HT82H791",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code > 0x0d)
>                 return "";
> @@ -499,5 +499,5 @@
>                 "SMBus",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code > 5)
>                 return "";
> @@ -527,5 +527,5 @@
>                 "Passive Cooling",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code > 0x11)
>                 return "";
> @@ -549,5 +549,5 @@
>                 "Add-in Card",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code > 0x0b)
>                 return "";
> @@ -563,8 +563,10 @@
>                 "Drive Back Plane",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code <= 0x0b)
>                 return dmi_volt_loc(code);
> -       return type[code - 0x0c];
> +       if (code <= 0x0f)
> +               return type[code - 0x0c];
> +       return "";
>  }
> 
> @@ -580,5 +582,5 @@
>                 "Non-recoverable",
>         };
> -       code &= 0x80;
> +       code &= ~0x80;
>         if (code > 6)
>                 return "";
> Index: prog/sensors/chips.c
> =================================> RCS file: /home/cvs/lm_sensors2/prog/sensors/chips.c,v
> retrieving revision 1.72
> diff -u -2 -r1.72 chips.c
> --- prog/sensors/chips.c        2002/08/23 21:32:08     1.72
> +++ prog/sensors/chips.c        2002/09/20 21:30:41
> @@ -2098,5 +2098,5 @@
>            print_label(label,10);
>            print_temp_info( cur, max, min, HYST, 1, 0);
> -          printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP2 ?"ALARM":"     ",
> +          printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP3 ?"ALARM":"     ",
>                   beeps&W83781D_ALARM_TEMP3?"(beep)":"");
>          } else {
