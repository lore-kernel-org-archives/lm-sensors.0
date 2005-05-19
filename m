From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: not sure how to report these
Message-Id: <3F590AE4.9080802@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F57E1B0.6040505@wesmo.com>
In-Reply-To: <3F57E1B0.6040505@wesmo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hey Rich, since we write drivers for the chips and not each motherboard, 
there is sometimes some mapping differences from computer to computer.  
Usually a -126 reading means that there is no sensor connected to that 
input on the chip.  You are probably right in guessing that temp3 is 
actually the CPU temp sensor.  The fan speed oddity is another issue we 
can see from motherboard to motherboard.  It's likely just another side 
effect of another atypical configuration.

You can often easily correct for these issues by editing 
/etc/sensors.conf to swap labels around and adjust computation factors.

Thanks for the note.  btw-Cricket looks cool, I'll have to check it out!


Phil

Rich West wrote:

> I've personally compensated for these issues, but I thought I would 
> help out and report what I have come across.
>
> Using the latest drivers, and going all of the way back to 2.6.3, the 
> gl520sm-i2c-0-2d driver on my ECS K7AMA motherboard (using the 
> i2c-ali1535 module), has always reported the fan speeds as twice their 
> actual value.
>
> The other issue is that I have an ECS K7S5A motherboard, using the 
> it87-isa-0290 driver (using the i2c-sis645 module), it seems to report 
> the temperatures strangely.
>
> It is listing:
> Temp1/MB:    +25C (min = +20C, max= +60C)
> Temp2/CPU:   -126C (min = +20C, max = +60C)
> Temp3:   +46C (min = +20C, max = +60C)
>
> So, it seems that my motherboard temp is 25C, and my CPU is at a 
> whopping -126C.  I'm not sure what Temp3 is.. :)
>
> I'm guessing it is reading something incorrectly.. Maybe, just maybe, 
> the CPU is at 46C (it ususally ran higher with my older processor.. 
> around 55C), but I would just be guessing.
>
> Thanks for the great software!  I've been using it for some time, in 
> combination with Cricket (cricket.sourceforge.net) and some modules I 
> contributed, to monitor my systems!
>
> -Rich
>
>
