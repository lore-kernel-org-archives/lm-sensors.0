From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: W83L785R Support
Message-Id: <Pine.LNX.4.58.0402211030190.3152@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402201842.48537.coflynn@newae.com>
In-Reply-To: <200402201842.48537.coflynn@newae.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I'm very sorry I have been very busy with writing my book. ANd now I'm as
exchange student in Sweden so I didnt have time to finish it.

But I have working /proc interface, supporting fan, pwm, temps and
temp_fault.

Only thing is missing are voltages monitoring.

This chip is on my motherboard and serving mainly for ASUS Cpu Overheat
PRotection. SOit has not connected much things. (no voltages, no FANs) I
want to solder PWM outputs and use it for speed regulation.

The driver is for sensors version 2.8.0

ruik$ ls /proc/sys/dev/sensors/w83785-i2c-1-2d/
fan_div  fan1  fan2  pwm_div  pwm1  pwm2  ram  temp_fault  temp1  temp2

If you want to test it, Colin, it would be nice.

Most of the files in /proc can be written.

Regards

Rudolf


On Sat, 21 Feb 2004, Jean Delvare wrote:

> Quoting Colin O'Flynn:
>
> > I'm interested in getting a W83L785R sensor working on my video card.
> > I can read from it fine (I actually patched the SCL/SDA lines from the
> > chip to my motherboard... I was having trouble getting the I2C bus on
> > the video card detected) at address 0x2d.
>
> What video card is it?
>
> > I see there is already a driver under development for this device, is
> > there any way I can find out the status and/or help?
>
> Back in August 2003, Rudolf Marek was working on one.
>
> Rudolf, do you have some working code you would like to share with Colin
> and the lm_sensors project?
>
> Thanks.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83784.c
Type: text/x-csrc
Size: 21835 bytes
Desc: here
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040221/7309d94b/w83784.bin
