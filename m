From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [2.5] Help with ICH5 SMBus and W83627THF
Message-Id: <1055781648.8803.5.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055775351.19204.11.camel@nosferatu.lan>
In-Reply-To: <1055775351.19204.11.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2003-06-16 at 18:31, Greg KH wrote:
> On Mon, Jun 16, 2003 at 04:55:51PM +0200, Martin Schlemmer wrote:
> > Hi
> > 
> > I have been trying to get the W83627THF chip working on this
> > board.  It is an Asus P4C800 with Intel 875p chipset and a
> > W83627THF connected via the SMBus.
> > 
> > There are no data sheet for the W83627THF as far as I can see,
> > but supposidly it is a W83627HF with advance Fan control, etc.
> > 
> > I have applied attached patches, and tried various other things
> > to get it to work, but no avail.  The SMBus on the ICH5 seems to
> > work, and it seems to detect the sensor chip just fine, but it
> > do not seem to read any values from the W83627THF.
> > 
> > PCI ID:
> > 
> > --------------------------
> >   Bus  0, device  31, function  3:
> >     SMBus: PCI device 8086:24d3 (Intel Corp.) (rev 2).
> >       IRQ 17.
> >       I/O at 0x400 [0x41f].
> > --------------------------
> > 
> > Kernel logs when loading drivers:
> > 
> > --------------------------
> > i2c-i801 version 2.7.0 (20021208)
> > w83781d:  Found sensor chip W83627HF chip, id 0x72
> > registering 1-002f
> > registering 1-0049
> > registering 1-0048
> > --------------------------
> > 
> > 
> > Sysfs files created:
> > 
> > --------------------------
> > nosferatu linux # ls /sys/bus/i2c/devices/1-002f
> > alarms       fan_div3    fan_min2   in_input3  in_input8  in_max4 
> > in_min0  in_min5  power        sensor2      temp_max1  temp_min3
> > beep_enable  fan_input1  fan_min3   in_input4  in_max0    in_max5 
> > in_min1  in_min6  pwm1         sensor3      temp_max2  vid
> > beep_mask    fan_input2  in_input0  in_input5  in_max1    in_max6 
> > in_min2  in_min7  pwm2         temp_input1  temp_max3  vrm
> > fan_div1     fan_input3  in_input1  in_input6  in_max2    in_max7 
> > in_min3  in_min8  pwm_enable2  temp_input2  temp_min1
> > fan_div2     fan_min1    in_input2  in_input7  in_max3    in_max8 
> > in_min4  name     sensor1      temp_input3  temp_min2
> 
> Looks good, what does any of these files say if you cat them?
> 
> Why do you think that you are not reading any values?
> 

Yep, but like I said .. it does not seem to read the correct values
from the chip.  I might be missing something simple though (common
in cases where you have been at it for a while =).

---------------------------------------------------
nosferatu root # cat /sys/bus/i2c/devices/0-002f/fan_input[123]
0
0
0
nosferatu root # cat /sys/bus/i2c/devices/0-002f/temp_input[123]
12700
12700
12700
nosferatu root # cat /sys/bus/i2c/devices/0-002f/in_input[0-8]  
0
0
112
3120
0
0
0
4080
4080
nosferatu root # 
-----------------------------------------------------

> And does the attached patch help any?  Or does it not do anything?
> 

I am guessing you forgot the patch ? :)


Regards,

-- 

Martin Schlemmer



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030616/80455c44/attachment.bin
