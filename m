From: mbates@whoopis.com (Marion Bates)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: voodoo3 3000, Fedora 2, lm_sensors, and tv-out
Message-Id: <F774B534-11A7-11D9-8BFC-003065B9194E@whoopis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4159F327.8080607@edgedesign.us>
In-Reply-To: <4159F327.8080607@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Wow, thanks for replying so fast!

I found another howto, very similar to Ollila's, here: 
http://www.perturb.org/content/linux-voodoo3.txt  and at least it gave 
me some diagnostic commands to run. Here they are, with their output:

---------------------------

[root@localhost lm_sensors-2.8.7]# lspci | grep VGA
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 
01)

(yay, the motherboard detects the card.)

---------------------------

[root@localhost lm_sensors-2.8.7]# lsmod | grep i2c
i2c_sensor              2176  2 w83781d,eeprom
i2c_i801                6160  0
i2c_voodoo3             3588  0
i2c_algo_bit            7304  1 i2c_voodoo3
i2c_core               16388  5 
w83781d,eeprom,i2c_sensor,i2c_i801,i2c_algo_bit

(His howto says "Specifically look for the voodoo3, proc, and core.  If 
you have those you're good to go." I don't have proc, and nothing 
refers to "bt869".)

---------------------------

[root@localhost lm_sensors-2.8.7]# ls /proc/sys/dev/
cdrom  raid  rtc  scsi

(no "sensors" subdir...waah)

---------------------------

[root@localhost lm_sensors-2.8.7]# sensors
as99127f-i2c-2-2d
Adapter: SMBus I801 adapter at e800
VCore 1:   +1.73 V  (min =  +1.62 V, max =  +1.78 V)              (beep)
VCore 2:   +1.73 V  (min =  +1.62 V, max =  +1.78 V)              (beep)
+3.3V:     +3.44 V  (min =  +3.14 V, max =  +3.46 V)              (beep)
+5V:       +5.03 V  (min =  +4.73 V, max =  +5.24 V)              (beep)
+12V:     +11.73 V  (min = +10.82 V, max = +13.19 V)              (beep)
-12V:     -11.76 V  (min = -13.22 V, max = -10.74 V)              (beep)
-5V:       -5.13 V  (min =  -5.25 V, max =  -4.74 V)              (beep)
fan1:        0 RPM  (min =    0 RPM, div = 2)                     (beep)
fan2:     4720 RPM  (min =    0 RPM, div = 2)                     (beep)
fan3:        0 RPM  (min =    0 RPM, div = 2)                     (beep)
M/B Temp:    +25?C  (high =  +105?C, hyst =    +0?C)          (beep)
CPU Temp:  +18.5?C  (high =   +80?C, hyst =   +75?C)          (beep)
temp3:     -31.5?C  (high =   +80?C, hyst =   +75?C)          (beep)
vid:      +1.700 V
alarms:
beep_enable:
           Sound alarm enabled

eeprom-i2c-0-50
Adapter: I2C Voodoo3/Banshee adapter
Unknown EEPROM type (255).

(I dunno what that's supposed to be telling me, but here it is anyway.)

---------------------------

[root@localhost lm_sensors-2.8.7]# modprobe -v bt869
FATAL: Module bt869 not found.

---------------------------

(this is my dead end.)

Does that tell you anything else? I assume that echoing settings into 
/proc/sys/dev/sensors/bt869*/res (or whatever) is fruitless if the 
"file" isn't already in the /proc virtual fs, right?

Thank you again. I really appreciate your help -- and if I get this 
working, I WILL write a howto and send you the url.   :)

-- MB

On Sep 28, 2004, at 7:26 PM, Philip Edelbrock wrote:

> It sounds like you are very close.  For everything to look/work right, 
> make sure you get your resolution set first, then configure the bt869. 
> Make sure you set its resolution and other parameters (PAL vs. NTSC) 
> to match what ever modeline you've got going in X.  The BT869 is a 
> pretty dumb chip.  It receives a raw stream of video data but doesn't 
> nessesarily know what the resolution is.  You have to tell it.
>
> If you've got black-and-white on the TV, then you probably just need 
> to set the settings while running in X to get things synced up.  What 
> I mean by this is that you need to do things like 'echo "640 480" > 
> /proc/sys/dev/sensors/bt869*/res' (or a path similar to this... this 
> is off the top of my head).
>
> I hope this helps.
