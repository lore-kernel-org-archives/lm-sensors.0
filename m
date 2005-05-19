From: coflynn@newae.com (Colin O'Flynn)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: W83L785R Support
Message-Id: <200402211024.05630.coflynn@newae.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402201842.48537.coflynn@newae.com>
In-Reply-To: <200402201842.48537.coflynn@newae.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the quick response!

> > What video card is it?

Its a GeForce 5600 MX, made my MSI - Part Number FX5600-VTD256. I've got no 
idea how the I2C bus gets put on the system normally, no bus was detected. 
Would the NVidia chip have the I2C controller in it or something? As you can 
see, I don't know a lot about how I2C works in the computer - in fact I just 
got lm_sensors working on Thursday!

I ended up lifting the two leads on the SSOP chip that were SCL and SDA, then 
putting them to the connector on the motherboard with wires...

> If you want to test it, Colin, it would be nice.

Alas, I'm using Kernel 2.6.0. It appears that driver was made for 2.4.x 
kernels (make sense considering it was made before 2.6!). I know very little 
about linux drivers, so I doubt I will be able to port it. I might try 
though, I was just comparing the drivers for a 2.6 vs 2.4 to try and figure 
out what you I've got to do... hmm.

I might end up doing what I am now... just use i2cdump 0 0x2d to read the 
data... not very nice, but it works!

Regards,

 -Colin



On February 21, 2004 09:40 am, Rudolf Marek wrote:
> Hello,
>
> I'm very sorry I have been very busy with writing my book. ANd now I'm as
> exchange student in Sweden so I didnt have time to finish it.
>
> But I have working /proc interface, supporting fan, pwm, temps and
> temp_fault.
>
> Only thing is missing are voltages monitoring.
>
> This chip is on my motherboard and serving mainly for ASUS Cpu Overheat
> PRotection. SOit has not connected much things. (no voltages, no FANs) I
> want to solder PWM outputs and use it for speed regulation.
>
> The driver is for sensors version 2.8.0
>
> ruik$ ls /proc/sys/dev/sensors/w83785-i2c-1-2d/
> fan_div  fan1  fan2  pwm_div  pwm1  pwm2  ram  temp_fault  temp1  temp2
>
> If you want to test it, Colin, it would be nice.
>
> Most of the files in /proc can be written.
>
> Regards
>
> Rudolf
>
> On Sat, 21 Feb 2004, Jean Delvare wrote:
> > Quoting Colin O'Flynn:
> > > I'm interested in getting a W83L785R sensor working on my video card.
> > > I can read from it fine (I actually patched the SCL/SDA lines from the
> > > chip to my motherboard... I was having trouble getting the I2C bus on
> > > the video card detected) at address 0x2d.
> >
> > What video card is it?
> >
> > > I see there is already a driver under development for this device, is
> > > there any way I can find out the status and/or help?
> >
> > Back in August 2003, Rudolf Marek was working on one.
> >
> > Rudolf, do you have some working code you would like to share with Colin
> > and the lm_sensors project?
> >
> > Thanks.
> >
> > --
> > Jean Delvare
> > http://www.ensicaen.ismra.fr/~delvare/
