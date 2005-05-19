From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <007201c49733$ef934970$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ----- Original Message ----- 
> From: "Nobody" <nobody@Stimpy.netroedge.com>
> To: <warp-9.9@usa.net>
> Sent: Friday, September 10, 2004 06:53
> Subject: ---== Lm_sensors Support DB Entry ==---
>
> Your Lm_sensors support entry has been updated.
>
> Please go to http://secure.netroedge.com/~lm78/support.html to check
> the status of your entry.
>
> Ticket # 1770

Hi,

I couldn't find a way to reply via the support ticket page.  The problem
was not solved on my end.

"sensors-detect" did in fact discover the W83781D device when probing
the ISA bus, at 0x290 as you mentioned.  I missed it before, but noticed
it when I did not load the ali15x3 adapter driver, and scanned the ISA
bus.

In "sensors.conf" I have tried 'chip "w83781d-*"' and 'chip
"w83781d-isa-*"', but running "sensors" says "No sensors found!".
Loaded modules are: w83781d, i2c_sensor, i2c_isa, i2c_core.  I also
tried with i2c_dev loaded, same result.  Am I missing a module or module
option?  Is it possible that the chip is detected on the ISA bus but not
accessible (misconfigured?) or not wired (unlikely?).  Do I need to
reboot when switching between SMBus and ISA?  If I wanted to use ISA but
still see the EEPROMs, would I still hang the bus?  Would I load both
the ali15x3 and isa adapter drivers? How would I configure sensors.conf?
With separate "w83781d-i2c-*" and "w83781d-isa-*" sections, with ALL
"w83781d-i2c-*" values ignored with optionally commented label, compute
and set?

Leif

/etc/modules has:
# I2C adapter drivers
#i2c-ali15x3
i2c-isa

# I2C chip drivers
w83781d
#eeprom

/etc/modules.conf has:
# I2C module options
alias char-major-89 i2c-dev
#options w83781d ignore=0,0x2d
#options w83781d ignore=1,0x2d

sensors.conf contains only this text (excluding the END comment below):

chip "w83781d-*"

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label temp1 "M/B Temp"
    label temp2 "CPU Temp"
    label fan2 "CPU Fan"

    ignore temp3
    ignore fan1
    ignore fan3

    compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  , @/((28/10)+1)
    compute in5 -(210/60.4)*@  , -@/(210/60.4)
    compute in6 -(90.9/60.4)*@ , -@/(90.9/60.4)

    set vrm 8.4 # 2.0V AMD K6-III+ 450/ACZ
    set in0_min vid * 0.95
    set in0_max vid * 1.05
    set in1_min vid * 0.95
    set in1_max vid * 1.05
    set in2_min 3.3 * 0.90
    set in2_max 3.3 * 1.10
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set temp1_over 35
    set temp1_hyst 30
    set temp2_over 40
    set temp2_hyst 35
    set fan2_div 2
    set fan2_min 3250
    set beep_enable 0


