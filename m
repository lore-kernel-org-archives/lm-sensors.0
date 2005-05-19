From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: lib/chips.h patch for kernel 2.6.X lm85 driver
Message-Id: <20040809214059.GC26019@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is associated lib/chips.h patch for the kernel 2.6.X lm85 driver.

Justin Thiessen
---------------
Linux Engineer
jthiessen@penguincomputing.com
http://www.penguincomputing.com


from

diff -Naur


--------------------------



--- lib/chips.h	2004-08-09 14:08:59.908807328 -0700
+++ lib/chips.h.new	2004-08-09 14:08:09.577458856 -0700
@@ -373,107 +373,142 @@
 #define SENSORS_ADT7463_PREFIX "adt7463"
 #define SENSORS_EMC6D100_PREFIX "emc6d100"
 
-#define SENSORS_ADM1027_ALARM_MASK           1  /* RW -- alarm_mask  */
-#define SENSORS_ADM1027_FAN1_PPR             2  /* RW -- fan1_ppr  */
-#define SENSORS_ADM1027_FAN1_TACH_MODE       3  /* RW -- fan1_tach_mode  */
-#define SENSORS_ADM1027_FAN2_PPR             4  /* RW -- fan2_ppr  */
-#define SENSORS_ADM1027_FAN2_TACH_MODE       5  /* RW -- fan2_tach_mode  */
-#define SENSORS_ADM1027_FAN3_PPR             6  /* RW -- fan3_ppr  */
-#define SENSORS_ADM1027_FAN3_TACH_MODE       7  /* RW -- fan3_tach_mode  */
-#define SENSORS_ADM1027_FAN4_PPR             8  /* RW -- fan4_ppr  */
-#define SENSORS_ADM1027_FAN4_TACH_MODE       9  /* RW -- fan4_tach_mode  */
-#define SENSORS_ADM1027_PWM1_SMOOTH         10  /* RW -- pwm1_smooth  */
-#define SENSORS_ADM1027_PWM2_SMOOTH         11  /* RW -- pwm2_smooth  */
-#define SENSORS_ADM1027_PWM3_SMOOTH         12  /* RW -- pwm3_smooth  */
-#define SENSORS_ADM1027_TEMP1_OFFSET        13  /* RW -- temp1_offset  */
-#define SENSORS_ADM1027_TEMP2_OFFSET        14  /* RW -- temp2_offset  */
-#define SENSORS_ADM1027_TEMP3_OFFSET        15  /* RW -- temp3_offset  */
-#define SENSORS_LM85_ALARMS                 16  /* R  -- alarms  */
-#define SENSORS_LM85_VID                    17  /* R  -- vid  */
-#define SENSORS_LM85_VRM                    18  /* RW -- vrm  */
-#define SENSORS_LM85_FAN1                   19  /* R  -- fan1  */
-#define SENSORS_LM85_FAN1_MIN               20  /* RW -- fan1_min  */
-#define SENSORS_LM85_FAN1_TACH_MODE         21  /* RW -- fan1_tach_mode  */
-#define SENSORS_LM85_FAN2                   22  /* R  -- fan2  */
-#define SENSORS_LM85_FAN2_MIN               23  /* RW -- fan2_min  */
-#define SENSORS_LM85_FAN2_TACH_MODE         24  /* RW -- fan2_tach_mode  */
-#define SENSORS_LM85_FAN3                   25  /* R  -- fan3  */
-#define SENSORS_LM85_FAN3_MIN               26  /* RW -- fan3_min  */
-#define SENSORS_LM85_FAN3_TACH_MODE         27  /* RW -- fan3_tach_mode  */
-#define SENSORS_LM85_FAN4                   28  /* R  -- fan4  */
-#define SENSORS_LM85_FAN4_MIN               29  /* RW -- fan4_min  */
-#define SENSORS_LM85_IN0                    30  /* R  -- in0  */
-#define SENSORS_LM85_IN0_MAX                31  /* RW -- in0_max  */
-#define SENSORS_LM85_IN0_MIN                32  /* RW -- in0_min  */
-#define SENSORS_LM85_IN1                    33  /* R  -- in1  */
-#define SENSORS_LM85_IN1_MAX                34  /* RW -- in1_max  */
-#define SENSORS_LM85_IN1_MIN                35  /* RW -- in1_min  */
-#define SENSORS_LM85_IN2                    36  /* R  -- in2  */
-#define SENSORS_LM85_IN2_MAX                37  /* RW -- in2_max  */
-#define SENSORS_LM85_IN2_MIN                38  /* RW -- in2_min  */
-#define SENSORS_LM85_IN3                    39  /* R  -- in3  */
-#define SENSORS_LM85_IN3_MAX                40  /* RW -- in3_max  */
-#define SENSORS_LM85_IN3_MIN                41  /* RW -- in3_min  */
-#define SENSORS_LM85_IN4                    42  /* R  -- in4  */
-#define SENSORS_LM85_IN4_MAX                43  /* RW -- in4_max  */
-#define SENSORS_LM85_IN4_MIN                44  /* RW -- in4_min  */
-#define SENSORS_LM85_IN5                    45  /* R  -- in5  */
-#define SENSORS_LM85_IN5_MAX                46  /* RW -- in5_max  */
-#define SENSORS_LM85_IN5_MIN                47  /* RW -- in5_min  */
-#define SENSORS_LM85_IN6                    48  /* R  -- in6  */
-#define SENSORS_LM85_IN6_MAX                49  /* RW -- in6_max  */
-#define SENSORS_LM85_IN6_MIN                50  /* RW -- in6_min  */
-#define SENSORS_LM85_IN7                    51  /* R  -- in7  */
-#define SENSORS_LM85_IN7_MAX                52  /* RW -- in7_max  */
-#define SENSORS_LM85_IN7_MIN                53  /* RW -- in7_min  */
-#define SENSORS_LM85_PWM1                   54  /* RW -- pwm1  */
-#define SENSORS_LM85_PWM1_FREQ              55  /* RW -- pwm1_freq  */
-#define SENSORS_LM85_PWM1_INVERT            56  /* RW -- pwm1_invert  */
-#define SENSORS_LM85_PWM1_MIN               57  /* RW -- pwm1_min  */
-#define SENSORS_LM85_PWM1_MIN_CTL           58  /* RW -- pwm1_min_ctl  */
-#define SENSORS_LM85_PWM1_SPINUP            59  /* RW -- pwm1_spinup  */
-#define SENSORS_LM85_PWM1_SPINUP_CTL        60  /* RW -- pwm1_spinup_ctl  */
-#define SENSORS_LM85_PWM1_ZONE              61  /* RW -- pwm1_zone  */
-#define SENSORS_LM85_PWM2                   62  /* RW -- pwm2  */
-#define SENSORS_LM85_PWM2_FREQ              63  /* RW -- pwm2_freq  */
-#define SENSORS_LM85_PWM2_INVERT            64  /* RW -- pwm2_invert  */
-#define SENSORS_LM85_PWM2_MIN               65  /* RW -- pwm2_min  */
-#define SENSORS_LM85_PWM2_MIN_CTL           66  /* RW -- pwm2_min_ctl  */
-#define SENSORS_LM85_PWM2_SPINUP            67  /* RW -- pwm2_spinup  */
-#define SENSORS_LM85_PWM2_SPINUP_CTL        68  /* RW -- pwm2_spinup_ctl  */
-#define SENSORS_LM85_PWM2_ZONE              69  /* RW -- pwm2_zone  */
-#define SENSORS_LM85_PWM3                   70  /* RW -- pwm3  */
-#define SENSORS_LM85_PWM3_FREQ              71  /* RW -- pwm3_freq  */
-#define SENSORS_LM85_PWM3_INVERT            72  /* RW -- pwm3_invert  */
-#define SENSORS_LM85_PWM3_MIN               73  /* RW -- pwm3_min  */
-#define SENSORS_LM85_PWM3_MIN_CTL           74  /* RW -- pwm3_min_ctl  */
-#define SENSORS_LM85_PWM3_SPINUP            75  /* RW -- pwm3_spinup  */
-#define SENSORS_LM85_PWM3_SPINUP_CTL        76  /* RW -- pwm3_spinup_ctl  */
-#define SENSORS_LM85_PWM3_ZONE              77  /* RW -- pwm3_zone  */
-#define SENSORS_LM85_TEMP1                  78  /* R  -- temp1  */
-#define SENSORS_LM85_TEMP1_MAX              79  /* RW -- temp1_max  */
-#define SENSORS_LM85_TEMP1_MIN              80  /* RW -- temp1_min  */
-#define SENSORS_LM85_TEMP2                  81  /* R  -- temp2  */
-#define SENSORS_LM85_TEMP2_MAX              82  /* RW -- temp2_max  */
-#define SENSORS_LM85_TEMP2_MIN              83  /* RW -- temp2_min  */
-#define SENSORS_LM85_TEMP3                  84  /* R  -- temp3  */
-#define SENSORS_LM85_TEMP3_MAX              85  /* RW -- temp3_max  */
-#define SENSORS_LM85_TEMP3_MIN              86  /* RW -- temp3_min  */
-#define SENSORS_LM85_ZONE1_CRITICAL         87  /* RW -- zone1_critical  */
-#define SENSORS_LM85_ZONE1_HYST             88  /* RW -- zone1_hyst  */
-#define SENSORS_LM85_ZONE1_LIMIT            89  /* RW -- zone1_limit  */
-#define SENSORS_LM85_ZONE1_RANGE            90  /* RW -- zone1_range  */
-#define SENSORS_LM85_ZONE1_SMOOTH           91  /* RW -- zone1_smooth  */
-#define SENSORS_LM85_ZONE2_CRITICAL         92  /* RW -- zone2_critical  */
-#define SENSORS_LM85_ZONE2_HYST             93  /* RW -- zone2_hyst  */
-#define SENSORS_LM85_ZONE2_LIMIT            94  /* RW -- zone2_limit  */
-#define SENSORS_LM85_ZONE2_RANGE            95  /* RW -- zone2_range  */
-#define SENSORS_LM85_ZONE2_SMOOTH           96  /* RW -- zone2_smooth  */
-#define SENSORS_LM85_ZONE3_CRITICAL         97  /* RW -- zone3_critical  */
-#define SENSORS_LM85_ZONE3_HYST             98  /* RW -- zone3_hyst  */
-#define SENSORS_LM85_ZONE3_LIMIT            99  /* RW -- zone3_limit  */
-#define SENSORS_LM85_ZONE3_RANGE           100  /* RW -- zone3_range  */
-#define SENSORS_LM85_ZONE3_SMOOTH          101  /* RW -- zone3_smooth  */
+#define SENSORS_LM85_VID   1  /* R  -- vid  (in0_ref) */
+#define SENSORS_LM85_VRM   2  /* RW -- vrm  */
+#define SENSORS_LM85_FAN1  3  /* R  -- fan1  */
+#define SENSORS_LM85_FAN1_MIN   4  /* RW -- fan1_min  */
+#define SENSORS_LM85_FAN1_TACH_MODE   5  /* RW -- fan1_tach_mode  */
+#define SENSORS_LM85_FAN1_PWM   6  /* RW -- fan1_pwm  */
+#define SENSORS_LM85_FAN2   7  /* R  -- fan2  */
+#define SENSORS_LM85_FAN2_MIN   8  /* RW -- fan2_min  */
+#define SENSORS_LM85_FAN2_TACH_MODE   9  /* RW -- fan2_tach_mode  */
+#define SENSORS_LM85_FAN2_PWM   10  /* RW -- fan2_pwm  */
+#define SENSORS_LM85_FAN3   11  /* R  -- fan3  */
+#define SENSORS_LM85_FAN3_MIN   12  /* RW -- fan3_min  */
+#define SENSORS_LM85_FAN3_TACH_MODE   13  /* RW -- fan3_tach_mode  */
+#define SENSORS_LM85_FAN3_PWM   14  /* RW -- fan3_pwm  */
+#define SENSORS_LM85_FAN4   15  /* R  -- fan4  */
+#define SENSORS_LM85_FAN4_MIN   16  /* RW -- fan4_min  */
+#define SENSORS_LM85_IN0   17  /* R  -- in0  */
+#define SENSORS_LM85_IN0_MAX   18  /* RW -- in0_max  */
+#define SENSORS_LM85_IN0_MIN   19  /* RW -- in0_min  */
+#define SENSORS_LM85_IN1   20  /* R  -- in1  */
+#define SENSORS_LM85_IN1_MAX   21  /* RW -- in1_max  */
+#define SENSORS_LM85_IN1_MIN   22  /* RW -- in1_min  */
+#define SENSORS_LM85_IN2   23  /* R  -- in2  */
+#define SENSORS_LM85_IN2_MAX   24  /* RW -- in2_max  */
+#define SENSORS_LM85_IN2_MIN   25  /* RW -- in2_min  */
+#define SENSORS_LM85_IN3   26  /* R  -- in3  */
+#define SENSORS_LM85_IN3_MAX   27  /* RW -- in3_max  */
+#define SENSORS_LM85_IN3_MIN   28  /* RW -- in3_min  */
+#define SENSORS_LM85_IN4   29  /* R  -- in4  */
+#define SENSORS_LM85_IN4_MAX   30  /* RW -- in4_max  */
+#define SENSORS_LM85_IN4_MIN   31  /* RW -- in4_min  */
+#define SENSORS_LM85_IN5   32  /* R  -- in5  */
+#define SENSORS_LM85_IN5_MAX   33  /* RW -- in5_max  */
+#define SENSORS_LM85_IN5_MIN   34  /* RW -- in5_min  */
+#define SENSORS_LM85_IN6   35  /* R  -- in6  */
+#define SENSORS_LM85_IN6_MAX   36  /* RW -- in6_max  */
+#define SENSORS_LM85_IN6_MIN   37  /* RW -- in6_min  */
+#define SENSORS_LM85_IN7   38  /* R  -- in7  */
+#define SENSORS_LM85_IN7_MAX   39  /* RW -- in7_max  */
+#define SENSORS_LM85_IN7_MIN   40  /* RW -- in7_min  */
+#define SENSORS_LM85_FAN1_AUTO   41  /* R  -- pwm1  */
+#define SENSORS_LM85_FAN1_AUTO_FREQ   42  /* RW -- fan1_auto_freq  */
+#define SENSORS_LM85_FAN1_AUTO_INVERT   43  /* RW -- fan1_auto_invert  */
+#define SENSORS_LM85_FAN1_AUTO_MIN_PWM   44  /* RW -- fan1_auto_min_pwm  */
+#define SENSORS_LM85_FAN1_AUTO_MIN_CTL   45  /* RW -- fan1_auto_min_ctl  */
+#define SENSORS_LM85_FAN1_AUTO_SPINUP   46  /* RW -- fan1_auto_spinup  */
+#define SENSORS_LM85_FAN1_AUTO_SPINUP_CTL   47  /* RW -- fan1_auto_spinup_ctl */
+#define SENSORS_LM85_FAN1_AUTO_ZONE   48  /* RW -- fan1_auto_zone  */
+#define SENSORS_LM85_FAN2_AUTO   49  /* R  -- pwm2  */
+#define SENSORS_LM85_FAN2_AUTO_FREQ   50  /* RW -- fan2_auto_freq  */
+#define SENSORS_LM85_FAN2_AUTO_INVERT   51  /* RW -- fan2_auto_invert  */
+#define SENSORS_LM85_FAN2_AUTO_MIN_PWM   52  /* RW -- fan2_auto_min_pwm  */
+#define SENSORS_LM85_FAN2_AUTO_MIN_CTL   53  /* RW -- fan2_auto_min_ctl  */
+#define SENSORS_LM85_FAN2_AUTO_SPINUP   54  /* RW -- fan2_auto_spinup  */
+#define SENSORS_LM85_FAN2_AUTO_SPINUP_CTL   55  /* RW -- fan2_auto_spinup_ctl */
+#define SENSORS_LM85_FAN2_AUTO_ZONE   56  /* RW -- fan2_auto_zone  */
+#define SENSORS_LM85_FAN3_AUTO   57  /* R  -- pwm3  */
+#define SENSORS_LM85_FAN3_AUTO_FREQ   58  /* RW -- fan3_auto_freq  */
+#define SENSORS_LM85_FAN3_AUTO_INVERT   59  /* RW -- fan3_auto_invert  */
+#define SENSORS_LM85_FAN3_AUTO_MIN_PWM   60  /* RW -- fan3_auto_min_pwm  */
+#define SENSORS_LM85_FAN3_AUTO_MIN_CTL   61  /* RW -- fan3_auto_min_ctl  */
+#define SENSORS_LM85_FAN3_AUTO_SPINUP   62  /* RW -- fan3_auto_spinup  */
+#define SENSORS_LM85_FAN3_AUTO_SPINUP_CTL   63  /* RW -- fan3_auto_spinup_ctl */
+#define SENSORS_LM85_FAN3_AUTO_ZONE   64  /* RW -- fan3_auto_zone  */
+#define SENSORS_LM85_TEMP1   65  /* R  -- temp1  */
+#define SENSORS_LM85_TEMP1_MAX   66  /* RW -- temp1_max  */
+#define SENSORS_LM85_TEMP1_MIN   67  /* RW -- temp1_min  */
+#define SENSORS_LM85_TEMP2   68  /* R  -- temp2  */
+#define SENSORS_LM85_TEMP2_MAX   69  /* RW -- temp2_max  */
+#define SENSORS_LM85_TEMP2_MIN   70  /* RW -- temp2_min  */
+#define SENSORS_LM85_TEMP3   71  /* R  -- temp3  */
+#define SENSORS_LM85_TEMP3_MAX   72  /* RW -- temp3_max  */
+#define SENSORS_LM85_TEMP3_MIN   73  /* RW -- temp3_min  */
+#define SENSORS_LM85_TEMP1_AUTO_CRITICAL   74  /* RW -- temp1_auto_critical  */
+#define SENSORS_LM85_TEMP1_AUTO_OFF   75  /* RW -- temp1_auto_off  */
+#define SENSORS_LM85_TEMP1_AUTO_MIN   76  /* RW -- temp1_auto_min  */
+#define SENSORS_LM85_TEMP1_AUTO_MAX   77  /* RW -- temp1_auto_max  */
+#define SENSORS_LM85_TEMP1_AUTO_SMOOTH   78  /* RW -- temp1_auto_smooth  */
+#define SENSORS_LM85_TEMP2_AUTO_CRITICAL   79  /* RW -- temp2_auto_critical  */
+#define SENSORS_LM85_TEMP2_AUTO_OFF   80  /* RW -- temp2_auto_off  */
+#define SENSORS_LM85_TEMP2_AUTO_MIN   81  /* RW -- temp2_auto_min  */
+#define SENSORS_LM85_TEMP2_AUTO_MAX   82  /* RW -- temp2_auto_max  */
+#define SENSORS_LM85_TEMP2_AUTO_SMOOTH   83  /* RW -- temp2_auto_smooth  */
+#define SENSORS_LM85_TEMP3_AUTO_CRITICAL   84  /* RW -- temp3_auto_critical  */
+#define SENSORS_LM85_TEMP3_AUTO_OFF   85  /* RW -- temp3_auto_off  */
+#define SENSORS_LM85_TEMP3_AUTO_MIN   86  /* RW -- temp3_auto_min  */
+#define SENSORS_LM85_TEMP3_AUTO_MAX   87  /* RW -- temp3_auto_max  */
+#define SENSORS_LM85_TEMP3_AUTO_SMOOTH   88  /* RW -- temp3_auto_smooth  */
+#define SENSORS_LM85_ALARMS   89  /* R  -- alarms  */
+#define SENSORS_ADM1027_ALARM_MASK_2500MV   90  /* RW -- alarm_mask_2500mv  */
+#define SENSORS_ADM1027_ALARM_MASK_VCCP   91  /* RW -- alarm_mask_vccp */
+#define SENSORS_ADM1027_ALARM_MASK_VCC   92  /* RW -- alarm_mask_vcc */
+#define SENSORS_ADM1027_ALARM_MASK_5000MV   93  /* RW -- alarm_mask_5000mv  */
+#define SENSORS_ADM1027_ALARM_MASK_TEMP1   94  /* RW -- alarm_mask_temp1   */
+#define SENSORS_ADM1027_ALARM_MASK_TEMP2   95  /* RW -- alarm_mask_temp2   */
+#define SENSORS_ADM1027_ALARM_MASK_TEMP3   96  /* RW -- alarm_mask_temp3   */
+#define SENSORS_ADM1027_ALARM_MASK_12000MV  97  /* RW -- alarm_mask_12000mv  */
+#define SENSORS_ADM1027_ALARM_MASK_THERM    98  /* RW -- alarm_mask_therm   */
+#define SENSORS_ADM1027_ALARM_MASK_FAN1   99  /* RW -- alarm_mask_fan1  */
+#define SENSORS_ADM1027_ALARM_MASK_FAN2   100  /* RW -- alarm_mask_fan2  */
+#define SENSORS_ADM1027_ALARM_MASK_FAN3   101  /* RW -- alarm_mask_fan3  */
+#define SENSORS_ADM1027_ALARM_MASK_FAN4   102  /* RW -- alarm_mask_fan4  */
+#define SENSORS_ADM1027_ALARM_MASK_REMOTE1_ELEC   103  /* RW -- \
+                                                       * alarm_mask_remote1
+                                                       * _elec */
+#define SENSORS_ADM1027_ALARM_MASK_REMOTE2_ELEC   104 /* RW -- \
+                                                       * alarm_mask_remote2
+                                                       * _elec */
+#define SENSORS_ADM1027_FAN_AUTO_SPINUP_CTL   105  /* RW -- \
+                                                    * fan_auto_spinup_ctl */
+#define SENSORS_ADM1027_FAN1_PPR   106  /* RW -- fan1_ppr  */
+#define SENSORS_ADM1027_FAN1_TACH_MODE   107  /* RW -- fan1_tach_mode  */
+#define SENSORS_ADM1027_FAN2_PPR   108  /* RW -- fan2_ppr  */
+#define SENSORS_ADM1027_FAN2_TACH_MODE   109  /* RW -- fan2_tach_mode  */
+#define SENSORS_ADM1027_FAN3_PPR   110  /* RW -- fan3_ppr  */
+#define SENSORS_ADM1027_FAN3_TACH_MODE   111  /* RW -- fan3_tach_mode  */
+#define SENSORS_ADM1027_FAN4_PPR   112  /* RW -- fan4_ppr  */
+#define SENSORS_ADM1027_FAN4_TACH_MODE   113  /* RW -- fan4_tach_mode  */
+#define SENSORS_ADM1027_PWM1_SMOOTH   114  /* RW -- pwm1_smooth  */
+#define SENSORS_ADM1027_PWM2_SMOOTH   115  /* RW -- pwm2_smooth  */
+#define SENSORS_ADM1027_PWM3_SMOOTH   116  /* RW -- pwm3_smooth  */
+#define SENSORS_ADM1027_TEMP1_OFFSET   117  /* RW -- temp1_offset  */
+#define SENSORS_ADM1027_TEMP2_OFFSET   118  /* RW -- temp2_offset  */
+#define SENSORS_ADM1027_TEMP3_OFFSET   119  /* RW -- temp3_offset  */
+#define SENSORS_ADT7463_THERM_LIMIT   120  /* RW -- therm_limit */
+#define SENSORS_ADT7463_THERM_TOTAL   121  /* R  -- therm_total */
+#define SENSORS_ADT7463_TEMP1_AUTO_DYNAMIC_TMIN_CTL   122  /* RW --
+                                                            * tmin_ctl */
+#define SENSORS_ADT7463_TEMP1_AUTO_OPPOINT   123  /* RW -- oppoint */
+#define SENSORS_ADT7463_TEMP2_AUTO_DYNAMIC_TMIN_CTL   124  /* RW --
+                                                            * tmin_ctl */
+#define SENSORS_ADT7463_TEMP2_AUTO_OPPOINT   125  /* RW -- oppoint */
+#define SENSORS_ADT7463_TEMP3_AUTO_DYNAMIC_TMIN_CTL   126  /* RW --
+                                                            * tmin_ctl */
+#define SENSORS_ADT7463_TEMP3_AUTO_OPPOINT   127  /* RW -- oppoint */
+
 
 /* LM86/LM89/LM90/LM99/ADM1032/MAX6657 chips */
 

