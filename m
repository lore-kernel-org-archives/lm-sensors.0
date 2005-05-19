From: Rich.West@wesmo.com (Rich West)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: not sure how to report these
Message-Id: <3F57E1B0.6040505@wesmo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've personally compensated for these issues, but I thought I would help 
out and report what I have come across.

Using the latest drivers, and going all of the way back to 2.6.3, the 
gl520sm-i2c-0-2d driver on my ECS K7AMA motherboard (using the 
i2c-ali1535 module), has always reported the fan speeds as twice their 
actual value.

The other issue is that I have an ECS K7S5A motherboard, using the 
it87-isa-0290 driver (using the i2c-sis645 module), it seems to report 
the temperatures strangely.

It is listing:
Temp1/MB:    +25C (min = +20C, max= +60C)
Temp2/CPU:   -126C (min = +20C, max = +60C)
Temp3:   +46C (min = +20C, max = +60C)

So, it seems that my motherboard temp is 25C, and my CPU is at a 
whopping -126C.  I'm not sure what Temp3 is.. :)

I'm guessing it is reading something incorrectly.. Maybe, just maybe, 
the CPU is at 46C (it ususally ran higher with my older processor.. 
around 55C), but I would just be guessing.

Thanks for the great software!  I've been using it for some time, in 
combination with Cricket (cricket.sourceforge.net) and some modules I 
contributed, to monitor my systems!

-Rich

