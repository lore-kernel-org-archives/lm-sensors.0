From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 09 Sep 2006 19:16:06 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <450312F6.4030500@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean,

Ive hacked separate voltage alarms into pc87360, and Ive chosen to
add a set_in_min_alarm() callback, which is contrary to the design given in
Doc/hwmon/sysfs-interface:

in[0-*]_min_alarm
in[0-*]_max_alarm
fan[1-*]_min_alarm
temp[1-*]_min_alarm
temp[1-*]_max_alarm
temp[1-*]_crit_alarm
                Limit alarm
                0: no alarm
                1: alarm
                RO                             <--------  conflict here.

So, to clear the alarm, I can now do
    echo 1 > in8_min_alarm
    or echo 0 > in8_min_alarm
to clear the alarm. I ignore the value, since otherwize writing 0 would 
do nothing,
and writing 0 is a reasonable expectation to turn off an alarm.


Heres my reason:

the Channel  Hi/Lo  Limit Exceeded bits are RW1C bits, ie write 1 to clear.
They are both part of the status register, which is a non-obvious way to 
clear the
alarm, and bit-position too, and the status attr-file is readonly anyway.

So here it is in action:

# sensors -s
# sensors
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +1.99 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +4.96 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +12.34 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.74 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.97 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.95 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.28 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +104 C  (low  =    +0 C, high =  +125 C)
Critical:   +126 C
Voltage ID:
          +0.000 V  (VRM Version 9.0)

as you can see, Vdd is lower than min, and ALARM is 'issued' by sensors

soekris:/sys/devices/platform/i2c-9191/9191-6620# ls in8*|more; cat in8*
in8_alarm
in8_input
in8_max
in8_max_alarm
in8_min
in8_min_alarm
in8_status
0
1477
1796
0
1501
2
131

here, I lower minimum, but alarm stays on, cuz its not (yet) explicitly 
cleared.

soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1450 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# ls in8*|more; cat in8*
in8_alarm
in8_input
in8_max
in8_max_alarm
in8_min
in8_min_alarm
in8_status
0
1465
1796
0
1453
2
131

now I clear it

soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 0 > in8_min_alarm
soekris:/sys/devices/platform/i2c-9191/9191-6620# ls in8*|more; cat in8*
in8_alarm
in8_input
in8_max
in8_max_alarm
in8_min
in8_min_alarm
in8_status
0
1477
1796
0
1453
0
145

<digressions>

status = 145 = 0x91.
bit 7 = 1 means:  New data not yet read.
this suggests that the conversion thats been read is incomplete, and 
presumably inaccurate in the LSBs

also,  in pc87360_detect, you set
        data->vrm = 90;

looking at hwmon-vid.c, the vrm value is clearly related to CPU voltages,
but this chip is a peripheral, so its not clear to me why you hardwired 
this number.
Not that it matters here, since the device is set up (by bios, AFAICT)
such that it doesnt print this
                    printk(KERN_INFO "pc87360: VID "
                           "inputs routed (mode %u)\n",

when it runs this, in static int __init pc87360_find

            /* Are we using thermistors? */
            if (*devid = 0xE9) { /* PC87366 */
                /* These registers are not logical-device
                   specific, just that we won't need them if
                   we don't use the VLM device */
                confreg[2] = superio_inb(sioaddr, 0x2B);
                confreg[3] = superio_inb(sioaddr, 0x25);

                if (confreg[2] & 0x40) {
                    printk(KERN_INFO "pc87360: Using "
                           "thermistors for temperature "
                           "monitoring\n");
                }
                if (confreg[3] & 0xE0) {
                    printk(KERN_INFO "pc87360: VID "
                           "inputs routed (mode %u)\n",
                           confreg[3] >> 5);
                }
            }

[ 7174.482859] pc87360: Device 0x09 not activated
[ 7175.525280] pc87360 9191-6620: VLM conversion set to 1s period, 160us 
delay

btw, 1s conversion period could be related to the "New data not yet read"

comments ?

