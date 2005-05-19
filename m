From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: 2.6.12-rc3-mm1 sysfs names
Message-Id: <5r08719a3rsjdnhs2ulhi5frmr16qe6jq2@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I currently have four proposed patches resolving some of the naming 
issues up for comments for drivers: adm1026, fscher and lm85.

--Grant.

# crossref-driver-sysfs_name (version: 2005-04-30 07:30)
# produced by Grant Coady <gcoady@gmail.com>
# /usr/src/linux-2.6.12-rc3-mm1/drivers/i2c/chips

* reference counted sysfs names

      1 alarm_mask
      1 alarms_in
      1 alarms_temp
      1 analog_out
      1 aout_output
      1 auto_fan1_channel
      1 auto_fan1_min_pwm
      1 auto_temp1_max
      1 auto_temp1_min
      1 auto_temp1_off
      1 control
      1 die_code
      1 event
      1 fan1_auto
      1 fan1_off
      1 fan1_ripple
      1 gpio
      1 gpio_mask
      1 in0_status
      1 out0_enable
      1 out0_output
      1 pwm1_auto_channels
      1 pwm1_auto_pwm_freq
      1 pwm1_auto_pwm_min
      1 pwm1_auto_pwm_minctl
      1 read
      1 revision
      1 temp1_auto_point1_pwm
      1 temp1_auto_point1_temp
      1 temp1_auto_point1_temp_hyst
      1 temp1_auto_temp_crit
      1 temp1_auto_temp_max
      1 temp1_auto_temp_min
      1 temp1_auto_temp_off
      1 temp1_crit_enable
      1 temp1_offset
      1 temp1_reset
      1 vid
      1 watchdog_control
      1 watchdog_preset
      1 watchdog_status
      1 wdog_control
      1 wdog_preset
      1 wdog_state
      1 write
      2 temp1_min_hyst
      3 fan1_status
      3 temp1_status
      3 temp1_type
      4 beep_enable
      4 beep_mask
      4 temp1_crit_hyst
      6 pwm1_enable
      9 cpu0_vid
      9 temp1_crit
      9 vrm
     12 pwm1
     12 temp1_max_hyst
     12 temp1_min
     15 in0_max
     15 in0_min
     16 fan1_div
     17 fan1_min
     18 in0_input
     20 fan1_input
     25 alarms
     25 temp1_max
     29 temp1_input

# crossref-driver-sysfs_name (version: 2005-04-30 07:30)
# produced by Grant Coady <gcoady@gmail.com>
# /usr/src/linux-2.6.12-rc3-mm1/drivers/i2c/chips

* drivers with unique sysfs names

adm1021.c    die_code                    R
adm1026.c    alarm_mask                  RW
adm1026.c    analog_out                  RW
adm1026.c    gpio                        RW
adm1026.c    gpio_mask                   RW
adm1026.c    gpio_mask                   RW
adm1026.c    temp1_auto_point1_pwm       RW
adm1026.c    temp1_auto_point1_temp      RW
adm1026.c    temp1_auto_point1_temp_hyst R
adm1026.c    temp1_auto_point1_temp_hyst R
adm1026.c    temp1_crit_enable           RW
adm1026.c    temp1_offset                RW
adm1026.c    vid                         R
adm1031.c    auto_fan1_channel           RW
adm1031.c    auto_fan1_min_pwm           RW
adm1031.c    auto_temp1_max              RW
adm1031.c    auto_temp1_min              RW
adm1031.c    auto_temp1_off              R
fscher.c     control                     RW
fscher.c     revision                    R
fscher.c     watchdog_control            RW
fscher.c     watchdog_preset             RW
fscher.c     watchdog_status             RW
fscpos.c     event                       R
fscpos.c     fan1_ripple                 RW
fscpos.c     temp1_reset                 RW
fscpos.c     wdog_control                RW
fscpos.c     wdog_preset                 RW
fscpos.c     wdog_state                  RW
gl518sm.c    fan1_auto                   WR
gl520sm.c    fan1_off                    RW
lm85.c       pwm1_auto_channels          RW
lm85.c       pwm1_auto_pwm_freq          RW
lm85.c       pwm1_auto_pwm_min           RW
lm85.c       pwm1_auto_pwm_minctl        RW
lm85.c       pwm1_auto_pwm_minctl        RW
lm85.c       temp1_auto_temp_crit        RW
lm85.c       temp1_auto_temp_max         RW
lm85.c       temp1_auto_temp_min         RW
lm85.c       temp1_auto_temp_off         RW
lm87.c       aout_output                 RW
pc87360.c    alarms_in                   R
pc87360.c    alarms_temp                 R
pc87360.c    in0_status                  R
pcf8574.c    read                        R
pcf8574.c    write                       WR
pcf8591.c    out0_enable                 WR
pcf8591.c    out0_output                 WR

# crossref-driver-sysfs_name (version: 2005-04-30 07:30)
# produced by Grant Coady <gcoady@gmail.com>
# /usr/src/linux-2.6.12-rc3-mm1/drivers/i2c/chips

* cross reference by sysfs name

alarm_mask                  adm1026.c    RW
alarms                      adm1021.c    R
alarms                      adm1025.c    R
alarms                      adm1026.c    R
alarms                      adm1031.c    R
alarms                      asb100.c     R
alarms                      ds1621.c     R
alarms                      fscher.c     R
alarms                      gl518sm.c    R
alarms                      gl520sm.c    R
alarms                      it87.c       R
alarms                      lm63.c       R
alarms                      lm77.c       R
alarms                      lm78.c       R
alarms                      lm80.c       R
alarms                      lm83.c       R
alarms                      lm85.c       R
alarms                      lm87.c       R
alarms                      lm90.c       R
alarms                      lm92.c       R
alarms                      max1619.c    R
alarms                      sis5595.c    R
alarms                      smsc47m1.c   R
alarms                      via686a.c    R
alarms                      w83627hf.c   R
alarms                      w83781d.c    R
alarms_in                   pc87360.c    R
alarms_temp                 pc87360.c    R
analog_out                  adm1026.c    RW
aout_output                 lm87.c       RW
auto_fan1_channel           adm1031.c    RW
auto_fan1_min_pwm           adm1031.c    RW
auto_temp1_max              adm1031.c    RW
auto_temp1_min              adm1031.c    RW
auto_temp1_off              adm1031.c    R
beep_enable                 gl518sm.c    WR
beep_enable                 gl520sm.c    RW
beep_enable                 w83627hf.c   RW
beep_enable                 w83781d.c    RW
beep_mask                   gl518sm.c    WR
beep_mask                   gl520sm.c    RW
beep_mask                   w83627hf.c   RW
beep_mask                   w83781d.c    RW
control                     fscher.c     RW
cpu0_vid                    asb100.c     R
cpu0_vid                    gl520sm.c    R
cpu0_vid                    it87.c       R
cpu0_vid                    lm78.c       R
cpu0_vid                    lm85.c       R
cpu0_vid                    lm87.c       R
cpu0_vid                    pc87360.c    R
cpu0_vid                    w83627hf.c   R
cpu0_vid                    w83781d.c    R
die_code                    adm1021.c    R
event                       fscpos.c     R
fan1_auto                   gl518sm.c    WR
fan1_div                    adm1026.c    RW
fan1_div                    adm1031.c    RW
fan1_div                    asb100.c     RW
fan1_div                    fscher.c     RW
fan1_div                    gl518sm.c    WR
fan1_div                    gl520sm.c    RW
fan1_div                    it87.c       RW
fan1_div                    lm78.c       RW
fan1_div                    lm80.c       WR
fan1_div                    lm87.c       RW
fan1_div                    pc87360.c    R
fan1_div                    sis5595.c    RW
fan1_div                    smsc47m1.c   RW
fan1_div                    via686a.c    RW
fan1_div                    w83627hf.c   RW
fan1_div                    w83781d.c    RW
fan1_input                  adm1026.c    R
fan1_input                  adm1031.c    R
fan1_input                  asb100.c     R
fan1_input                  fscher.c     R
fan1_input                  fscpos.c     R
fan1_input                  gl518sm.c    R
fan1_input                  gl520sm.c    R
fan1_input                  it87.c       R
fan1_input                  lm63.c       R
fan1_input                  lm78.c       R
fan1_input                  lm80.c       R
fan1_input                  lm85.c       R
fan1_input                  lm87.c       R
fan1_input                  pc87360.c    R
fan1_input                  sis5595.c    R
fan1_input                  smsc47b397.c R
fan1_input                  smsc47m1.c   R
fan1_input                  via686a.c    R
fan1_input                  w83627hf.c   R
fan1_input                  w83781d.c    R
fan1_min                    adm1026.c    RW
fan1_min                    adm1031.c    RW
fan1_min                    asb100.c     RW
fan1_min                    gl518sm.c    WR
fan1_min                    gl520sm.c    RW
fan1_min                    it87.c       RW
fan1_min                    lm63.c       WR
fan1_min                    lm78.c       RW
fan1_min                    lm80.c       WR
fan1_min                    lm85.c       RW
fan1_min                    lm87.c       RW
fan1_min                    pc87360.c    WR
fan1_min                    sis5595.c    RW
fan1_min                    smsc47m1.c   RW
fan1_min                    via686a.c    RW
fan1_min                    w83627hf.c   RW
fan1_min                    w83781d.c    RW
fan1_off                    gl520sm.c    RW
fan1_ripple                 fscpos.c     RW
fan1_status                 fscher.c     RW
fan1_status                 fscpos.c     R
fan1_status                 pc87360.c    R
gpio                        adm1026.c    RW
gpio_mask                   adm1026.c    RW
in0_input                   adm1025.c    R
in0_input                   adm1026.c    R
in0_input                   asb100.c     R
in0_input                   fscher.c     R
in0_input                   fscpos.c     R
in0_input                   gl518sm.c    R
in0_input                   gl520sm.c    R
in0_input                   it87.c       R
in0_input                   lm78.c       R
in0_input                   lm80.c       R
in0_input                   lm85.c       R
in0_input                   lm87.c       R
in0_input                   pc87360.c    R
in0_input                   pcf8591.c    R
in0_input                   sis5595.c    R
in0_input                   via686a.c    R
in0_input                   w83627hf.c   R
in0_input                   w83781d.c    R
in0_max                     adm1025.c    WR
in0_max                     adm1026.c    RW
in0_max                     asb100.c     RW
in0_max                     gl518sm.c    WR
in0_max                     gl520sm.c    RW
in0_max                     it87.c       RW
in0_max                     lm78.c       RW
in0_max                     lm80.c       WR
in0_max                     lm85.c       RW
in0_max                     lm87.c       RW
in0_max                     pc87360.c    WR
in0_max                     sis5595.c    RW
in0_max                     via686a.c    RW
in0_max                     w83627hf.c   RW
in0_max                     w83781d.c    RW
in0_min                     adm1025.c    WR
in0_min                     adm1026.c    RW
in0_min                     asb100.c     RW
in0_min                     gl518sm.c    WR
in0_min                     gl520sm.c    RW
in0_min                     it87.c       RW
in0_min                     lm78.c       RW
in0_min                     lm80.c       WR
in0_min                     lm85.c       RW
in0_min                     lm87.c       RW
in0_min                     pc87360.c    WR
in0_min                     sis5595.c    RW
in0_min                     via686a.c    RW
in0_min                     w83627hf.c   RW
in0_min                     w83781d.c    RW
in0_status                  pc87360.c    R
out0_enable                 pcf8591.c    WR
out0_output                 pcf8591.c    WR
pwm1                        adm1026.c    RW
pwm1                        adm1031.c    RW
pwm1                        asb100.c     RW
pwm1                        fscher.c     RW
pwm1                        fscpos.c     RW
pwm1                        it87.c       RW
pwm1                        lm63.c       WR
pwm1                        lm85.c       RW
pwm1                        pc87360.c    WR
pwm1                        smsc47m1.c   RW
pwm1                        w83627hf.c   RW
pwm1                        w83781d.c    RW
pwm1_auto_channels          lm85.c       RW
pwm1_auto_pwm_freq          lm85.c       RW
pwm1_auto_pwm_min           lm85.c       RW
pwm1_auto_pwm_minctl        lm85.c       RW
pwm1_enable                 adm1026.c    RW
pwm1_enable                 asb100.c     RW
pwm1_enable                 it87.c       RW
pwm1_enable                 lm63.c       R
pwm1_enable                 lm85.c       R
pwm1_enable                 smsc47m1.c   RW
read                        pcf8574.c    R
revision                    fscher.c     R
temp1_auto_point1_pwm       adm1026.c    RW
temp1_auto_point1_temp      adm1026.c    RW
temp1_auto_point1_temp_hyst adm1026.c    R
temp1_auto_temp_crit        lm85.c       RW
temp1_auto_temp_max         lm85.c       RW
temp1_auto_temp_min         lm85.c       RW
temp1_auto_temp_off         lm85.c       RW
temp1_crit                  adm1026.c    RW
temp1_crit                  adm1031.c    RW
temp1_crit                  lm77.c       WR
temp1_crit                  lm80.c       WR
temp1_crit                  lm83.c       R
temp1_crit                  lm87.c       R
temp1_crit                  lm90.c       WR
temp1_crit                  lm92.c       WR
temp1_crit                  pc87360.c    WR
temp1_crit_enable           adm1026.c    RW
temp1_crit_hyst             lm77.c       WR
temp1_crit_hyst             lm80.c       WR
temp1_crit_hyst             lm90.c       WR
temp1_crit_hyst             lm92.c       WR
temp1_input                 adm1021.c    R
temp1_input                 adm1025.c    R
temp1_input                 adm1026.c    R
temp1_input                 adm1031.c    R
temp1_input                 asb100.c     R
temp1_input                 ds1621.c     R
temp1_input                 fscher.c     R
temp1_input                 fscpos.c     R
temp1_input                 gl518sm.c    R
temp1_input                 gl520sm.c    R
temp1_input                 it87.c       R
temp1_input                 lm63.c       R
temp1_input                 lm75.c       R
temp1_input                 lm77.c       R
temp1_input                 lm78.c       R
temp1_input                 lm80.c       R
temp1_input                 lm83.c       R
temp1_input                 lm85.c       R
temp1_input                 lm87.c       R
temp1_input                 lm90.c       R
temp1_input                 lm92.c       R
temp1_input                 max1619.c    R
temp1_input                 pc87360.c    R
temp1_input                 sis5595.c    R
temp1_input                 smsc47b397.c R
temp1_input                 via686a.c    R
temp1_input                 w83627hf.c   R
temp1_input                 w83781d.c    R
temp1_input                 w83l785ts.c  R
temp1_max                   adm1021.c    WR
temp1_max                   adm1025.c    WR
temp1_max                   adm1026.c    RW
temp1_max                   adm1031.c    RW
temp1_max                   asb100.c     RW
temp1_max                   ds1621.c     WR
temp1_max                   gl518sm.c    WR
temp1_max                   gl520sm.c    RW
temp1_max                   it87.c       RW
temp1_max                   lm63.c       WR
temp1_max                   lm75.c       WR
temp1_max                   lm77.c       WR
temp1_max                   lm78.c       RW
temp1_max                   lm80.c       WR
temp1_max                   lm83.c       WR
temp1_max                   lm85.c       RW
temp1_max                   lm87.c       RW
temp1_max                   lm90.c       WR
temp1_max                   lm92.c       WR
temp1_max                   pc87360.c    WR
temp1_max                   sis5595.c    RW
temp1_max                   via686a.c    RW
temp1_max                   w83627hf.c   RW
temp1_max                   w83781d.c    RW
temp1_max                   w83l785ts.c  R
temp1_max_hyst              asb100.c     RW
temp1_max_hyst              gl518sm.c    WR
temp1_max_hyst              gl520sm.c    RW
temp1_max_hyst              lm75.c       WR
temp1_max_hyst              lm77.c       R
temp1_max_hyst              lm78.c       RW
temp1_max_hyst              lm80.c       WR
temp1_max_hyst              lm92.c       R
temp1_max_hyst              sis5595.c    RW
temp1_max_hyst              via686a.c    RW
temp1_max_hyst              w83627hf.c   RW
temp1_max_hyst              w83781d.c    RW
temp1_min                   adm1021.c    WR
temp1_min                   adm1025.c    WR
temp1_min                   adm1026.c    RW
temp1_min                   adm1031.c    RW
temp1_min                   ds1621.c     WR
temp1_min                   it87.c       RW
temp1_min                   lm77.c       WR
temp1_min                   lm85.c       RW
temp1_min                   lm87.c       RW
temp1_min                   lm90.c       WR
temp1_min                   lm92.c       WR
temp1_min                   pc87360.c    WR
temp1_min_hyst              lm77.c       R
temp1_min_hyst              lm92.c       R
temp1_offset                adm1026.c    RW
temp1_reset                 fscpos.c     RW
temp1_status                fscher.c     RW
temp1_status                fscpos.c     R
temp1_status                pc87360.c    R
temp1_type                  it87.c       RW
temp1_type                  w83627hf.c   RW
temp1_type                  w83781d.c    RW
vid                         adm1026.c    R
vrm                         adm1025.c    RW
vrm                         adm1026.c    RW
vrm                         asb100.c     RW
vrm                         it87.c       RW
vrm                         lm85.c       RW
vrm                         lm87.c       RW
vrm                         pc87360.c    RW
vrm                         w83627hf.c   RW
vrm                         w83781d.c    RW
watchdog_control            fscher.c     RW
watchdog_preset             fscher.c     RW
watchdog_status             fscher.c     RW
wdog_control                fscpos.c     RW
wdog_preset                 fscpos.c     RW
wdog_state                  fscpos.c     RW
write                       pcf8574.c    WR

# crossref-driver-sysfs_name (version: 2005-04-30 07:30)
# produced by Grant Coady <gcoady@gmail.com>
# /usr/src/linux-2.6.12-rc3-mm1/drivers/i2c/chips

* cross reference by driver name

adm1021.c    alarms                      R
adm1021.c    die_code                    R
adm1021.c    temp1_input                 R
adm1021.c    temp1_max                   WR
adm1021.c    temp1_min                   WR
adm1025.c    alarms                      R
adm1025.c    in0_input                   R
adm1025.c    in0_max                     WR
adm1025.c    in0_min                     WR
adm1025.c    temp1_input                 R
adm1025.c    temp1_max                   WR
adm1025.c    temp1_min                   WR
adm1025.c    vrm                         RW
adm1026.c    alarm_mask                  RW
adm1026.c    alarms                      R
adm1026.c    analog_out                  RW
adm1026.c    fan1_div                    RW
adm1026.c    fan1_input                  R
adm1026.c    fan1_min                    RW
adm1026.c    gpio                        RW
adm1026.c    gpio_mask                   RW
adm1026.c    in0_input                   R
adm1026.c    in0_max                     RW
adm1026.c    in0_min                     RW
adm1026.c    pwm1                        RW
adm1026.c    pwm1_enable                 RW
adm1026.c    temp1_auto_point1_pwm       RW
adm1026.c    temp1_auto_point1_temp      RW
adm1026.c    temp1_auto_point1_temp_hyst R
adm1026.c    temp1_crit                  RW
adm1026.c    temp1_crit_enable           RW
adm1026.c    temp1_input                 R
adm1026.c    temp1_max                   RW
adm1026.c    temp1_min                   RW
adm1026.c    temp1_offset                RW
adm1026.c    vid                         R
adm1026.c    vrm                         RW
adm1031.c    alarms                      R
adm1031.c    auto_fan1_channel           RW
adm1031.c    auto_fan1_min_pwm           RW
adm1031.c    auto_temp1_max              RW
adm1031.c    auto_temp1_min              RW
adm1031.c    auto_temp1_off              R
adm1031.c    fan1_div                    RW
adm1031.c    fan1_input                  R
adm1031.c    fan1_min                    RW
adm1031.c    pwm1                        RW
adm1031.c    temp1_crit                  RW
adm1031.c    temp1_input                 R
adm1031.c    temp1_max                   RW
adm1031.c    temp1_min                   RW
asb100.c     alarms                      R
asb100.c     cpu0_vid                    R
asb100.c     fan1_div                    RW
asb100.c     fan1_input                  R
asb100.c     fan1_min                    RW
asb100.c     in0_input                   R
asb100.c     in0_max                     RW
asb100.c     in0_min                     RW
asb100.c     pwm1                        RW
asb100.c     pwm1_enable                 RW
asb100.c     temp1_input                 R
asb100.c     temp1_max                   RW
asb100.c     temp1_max_hyst              RW
asb100.c     vrm                         RW
ds1621.c     alarms                      R
ds1621.c     temp1_input                 R
ds1621.c     temp1_max                   WR
ds1621.c     temp1_min                   WR
fscher.c     alarms                      R
fscher.c     control                     RW
fscher.c     fan1_div                    RW
fscher.c     fan1_input                  R
fscher.c     fan1_status                 RW
fscher.c     in0_input                   R
fscher.c     pwm1                        RW
fscher.c     revision                    R
fscher.c     temp1_input                 R
fscher.c     temp1_status                RW
fscher.c     watchdog_control            RW
fscher.c     watchdog_preset             RW
fscher.c     watchdog_status             RW
fscpos.c     event                       R
fscpos.c     fan1_input                  R
fscpos.c     fan1_ripple                 RW
fscpos.c     fan1_status                 R
fscpos.c     in0_input                   R
fscpos.c     pwm1                        RW
fscpos.c     temp1_input                 R
fscpos.c     temp1_reset                 RW
fscpos.c     temp1_status                R
fscpos.c     wdog_control                RW
fscpos.c     wdog_preset                 RW
fscpos.c     wdog_state                  RW
gl518sm.c    alarms                      R
gl518sm.c    beep_enable                 WR
gl518sm.c    beep_mask                   WR
gl518sm.c    fan1_auto                   WR
gl518sm.c    fan1_div                    WR
gl518sm.c    fan1_input                  R
gl518sm.c    fan1_min                    WR
gl518sm.c    in0_input                   R
gl518sm.c    in0_max                     WR
gl518sm.c    in0_min                     WR
gl518sm.c    temp1_input                 R
gl518sm.c    temp1_max                   WR
gl518sm.c    temp1_max_hyst              WR
gl520sm.c    alarms                      R
gl520sm.c    beep_enable                 RW
gl520sm.c    beep_mask                   RW
gl520sm.c    cpu0_vid                    R
gl520sm.c    fan1_div                    RW
gl520sm.c    fan1_input                  R
gl520sm.c    fan1_min                    RW
gl520sm.c    fan1_off                    RW
gl520sm.c    in0_input                   R
gl520sm.c    in0_max                     RW
gl520sm.c    in0_min                     RW
gl520sm.c    temp1_input                 R
gl520sm.c    temp1_max                   RW
gl520sm.c    temp1_max_hyst              RW
it87.c       alarms                      R
it87.c       cpu0_vid                    R
it87.c       fan1_div                    RW
it87.c       fan1_input                  R
it87.c       fan1_min                    RW
it87.c       in0_input                   R
it87.c       in0_max                     RW
it87.c       in0_min                     RW
it87.c       pwm1                        RW
it87.c       pwm1_enable                 RW
it87.c       temp1_input                 R
it87.c       temp1_max                   RW
it87.c       temp1_min                   RW
it87.c       temp1_type                  RW
it87.c       vrm                         RW
lm63.c       alarms                      R
lm63.c       fan1_input                  R
lm63.c       fan1_min                    WR
lm63.c       pwm1                        WR
lm63.c       pwm1_enable                 R
lm63.c       temp1_input                 R
lm63.c       temp1_max                   WR
lm75.c       temp1_input                 R
lm75.c       temp1_max                   WR
lm75.c       temp1_max_hyst              WR
lm77.c       alarms                      R
lm77.c       temp1_crit                  WR
lm77.c       temp1_crit_hyst             WR
lm77.c       temp1_input                 R
lm77.c       temp1_max                   WR
lm77.c       temp1_max_hyst              R
lm77.c       temp1_min                   WR
lm77.c       temp1_min_hyst              R
lm78.c       alarms                      R
lm78.c       cpu0_vid                    R
lm78.c       fan1_div                    RW
lm78.c       fan1_input                  R
lm78.c       fan1_min                    RW
lm78.c       in0_input                   R
lm78.c       in0_max                     RW
lm78.c       in0_min                     RW
lm78.c       temp1_input                 R
lm78.c       temp1_max                   RW
lm78.c       temp1_max_hyst              RW
lm80.c       alarms                      R
lm80.c       fan1_div                    WR
lm80.c       fan1_input                  R
lm80.c       fan1_min                    WR
lm80.c       in0_input                   R
lm80.c       in0_max                     WR
lm80.c       in0_min                     WR
lm80.c       temp1_crit                  WR
lm80.c       temp1_crit_hyst             WR
lm80.c       temp1_input                 R
lm80.c       temp1_max                   WR
lm80.c       temp1_max_hyst              WR
lm83.c       alarms                      R
lm83.c       temp1_crit                  R
lm83.c       temp1_input                 R
lm83.c       temp1_max                   WR
lm85.c       alarms                      R
lm85.c       cpu0_vid                    R
lm85.c       fan1_input                  R
lm85.c       fan1_min                    RW
lm85.c       in0_input                   R
lm85.c       in0_max                     RW
lm85.c       in0_min                     RW
lm85.c       pwm1                        RW
lm85.c       pwm1_auto_channels          RW
lm85.c       pwm1_auto_pwm_freq          RW
lm85.c       pwm1_auto_pwm_min           RW
lm85.c       pwm1_auto_pwm_minctl        RW
lm85.c       pwm1_enable                 R
lm85.c       temp1_auto_temp_crit        RW
lm85.c       temp1_auto_temp_max         RW
lm85.c       temp1_auto_temp_min         RW
lm85.c       temp1_auto_temp_off         RW
lm85.c       temp1_input                 R
lm85.c       temp1_max                   RW
lm85.c       temp1_min                   RW
lm85.c       vrm                         RW
lm87.c       alarms                      R
lm87.c       aout_output                 RW
lm87.c       cpu0_vid                    R
lm87.c       fan1_div                    RW
lm87.c       fan1_input                  R
lm87.c       fan1_min                    RW
lm87.c       in0_input                   R
lm87.c       in0_max                     RW
lm87.c       in0_min                     RW
lm87.c       temp1_crit                  R
lm87.c       temp1_input                 R
lm87.c       temp1_max                   RW
lm87.c       temp1_min                   RW
lm87.c       vrm                         RW
lm90.c       alarms                      R
lm90.c       temp1_crit                  WR
lm90.c       temp1_crit_hyst             WR
lm90.c       temp1_input                 R
lm90.c       temp1_max                   WR
lm90.c       temp1_min                   WR
lm92.c       alarms                      R
lm92.c       temp1_crit                  WR
lm92.c       temp1_crit_hyst             WR
lm92.c       temp1_input                 R
lm92.c       temp1_max                   WR
lm92.c       temp1_max_hyst              R
lm92.c       temp1_min                   WR
lm92.c       temp1_min_hyst              R
max1619.c    alarms                      R
max1619.c    temp1_input                 R
pc87360.c    alarms_in                   R
pc87360.c    alarms_temp                 R
pc87360.c    cpu0_vid                    R
pc87360.c    fan1_div                    R
pc87360.c    fan1_input                  R
pc87360.c    fan1_min                    WR
pc87360.c    fan1_status                 R
pc87360.c    in0_input                   R
pc87360.c    in0_max                     WR
pc87360.c    in0_min                     WR
pc87360.c    in0_status                  R
pc87360.c    pwm1                        WR
pc87360.c    temp1_crit                  WR
pc87360.c    temp1_input                 R
pc87360.c    temp1_max                   WR
pc87360.c    temp1_min                   WR
pc87360.c    temp1_status                R
pc87360.c    vrm                         RW
pcf8574.c    read                        R
pcf8574.c    write                       WR
pcf8591.c    in0_input                   R
pcf8591.c    out0_enable                 WR
pcf8591.c    out0_output                 WR
sis5595.c    alarms                      R
sis5595.c    fan1_div                    RW
sis5595.c    fan1_input                  R
sis5595.c    fan1_min                    RW
sis5595.c    in0_input                   R
sis5595.c    in0_max                     RW
sis5595.c    in0_min                     RW
sis5595.c    temp1_input                 R
sis5595.c    temp1_max                   RW
sis5595.c    temp1_max_hyst              RW
smsc47b397.c fan1_input                  R
smsc47b397.c temp1_input                 R
smsc47m1.c   alarms                      R
smsc47m1.c   fan1_div                    RW
smsc47m1.c   fan1_input                  R
smsc47m1.c   fan1_min                    RW
smsc47m1.c   pwm1                        RW
smsc47m1.c   pwm1_enable                 RW
via686a.c    alarms                      R
via686a.c    fan1_div                    RW
via686a.c    fan1_input                  R
via686a.c    fan1_min                    RW
via686a.c    in0_input                   R
via686a.c    in0_max                     RW
via686a.c    in0_min                     RW
via686a.c    temp1_input                 R
via686a.c    temp1_max                   RW
via686a.c    temp1_max_hyst              RW
w83627hf.c   alarms                      R
w83627hf.c   beep_enable                 RW
w83627hf.c   beep_mask                   RW
w83627hf.c   cpu0_vid                    R
w83627hf.c   fan1_div                    RW
w83627hf.c   fan1_input                  R
w83627hf.c   fan1_min                    RW
w83627hf.c   in0_input                   R
w83627hf.c   in0_max                     RW
w83627hf.c   in0_min                     RW
w83627hf.c   pwm1                        RW
w83627hf.c   temp1_input                 R
w83627hf.c   temp1_max                   RW
w83627hf.c   temp1_max_hyst              RW
w83627hf.c   temp1_type                  RW
w83627hf.c   vrm                         RW
w83781d.c    alarms                      R
w83781d.c    beep_enable                 RW
w83781d.c    beep_mask                   RW
w83781d.c    cpu0_vid                    R
w83781d.c    fan1_div                    RW
w83781d.c    fan1_input                  R
w83781d.c    fan1_min                    RW
w83781d.c    in0_input                   R
w83781d.c    in0_max                     RW
w83781d.c    in0_min                     RW
w83781d.c    pwm1                        RW
w83781d.c    temp1_input                 R
w83781d.c    temp1_max                   RW
w83781d.c    temp1_max_hyst              RW
w83781d.c    temp1_type                  RW
w83781d.c    vrm                         RW
w83l785ts.c  temp1_input                 R
w83l785ts.c  temp1_max                   R
