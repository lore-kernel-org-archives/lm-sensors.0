From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 27 Jun 2006 14:58:33 +0000
Subject: [lm-sensors] i2c-i801 on Intel Server Board se7525gp2?
Message-Id: <44A14799.80904@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
In-Reply-To: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nick Ellson wrote:
> I am hoping to get some help understanding why lm_sensors is not finding 
> what it need on my two servers. I am trying to follow the Identifying your 
> Hardware process and this is what I get:
>
> gubbie ~ # /usr/bin/sensors -s
> Can't access procfs/sysfs file
>   

This is where things have gone wrong.
Is this a kernel you configured and built ?
You have 2 identical boxes, I guess both fail the same way ?

I have noticed the absense of /sys/* directory exactly 2x,
both times it was transient (corrected on next boot, wo any other changes)
I dont recall finding any similar reports, but also dont recall how 
thoroughly I searched.

Esp if youve built your own kernel,
you should try a few of the live-CDs out there, and see if they are able 
to create a /sys dir.

> I have the I2C stuff and Hardware Monitoring sections in my Kernel all 
> <M>odularized.
>
>
> Have I over loked anything?
>
>
> Nick
>
>
>   


