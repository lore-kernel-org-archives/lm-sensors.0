From: grimm@nickellson.com (Nick Ellson)
Date: Tue, 27 Jun 2006 15:15:29 +0000
Subject: [lm-sensors] i2c-i801 on Intel Server Board se7525gp2?
Message-Id: <Pine.LNX.4.64.0606270808480.21180@gubbie.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
In-Reply-To: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Jim,

It is my own Kernel in the sense that with Gentoo the install process I 
need to pick the features that match my system. The SMP stuff and drive 
controllers, network, the basics.

I do not add any odd patches to my kernel.

And yep, I bought two systems at the same time so that they would be 
identical so I could try software on one and work out the kinks before 
messing with my E-mail/DNS box.

What I have learned is that the E7525 chipset is known to not report any 
sensors. While I would love that not to be true, I have found no evidence 
that they can be read by lm-sensors. Intel's sensor observation drivers 
are for RedHat only as far as Linux goes, so I am not sure if they will 
work under Gentoo.

I am now looking at alternative solutions. I seem to have this kind of 
luck with systems, always picking one that Linux is shut out from the nice 
features on the hardware. :\

Nick

-- 
Nick Ellson
CCDA, CCNP, CCSP, CCAI,
MCSE 2000, Security+, Network+
Network Hobbyist, VFR Private Pilot.


On Tue, 27 Jun 2006, Jim Cromie wrote:

> Nick Ellson wrote:
>>  I am hoping to get some help understanding why lm_sensors is not finding
>>  what it need on my two servers. I am trying to follow the Identifying your
>>  Hardware process and this is what I get:
>>
>>  gubbie ~ # /usr/bin/sensors -s
>>  Can't access procfs/sysfs file
>> 
>
> This is where things have gone wrong.
> Is this a kernel you configured and built ?
> You have 2 identical boxes, I guess both fail the same way ?
>
> I have noticed the absense of /sys/* directory exactly 2x,
> both times it was transient (corrected on next boot, wo any other changes)
> I dont recall finding any similar reports, but also dont recall how 
> thoroughly I searched.
>
> Esp if youve built your own kernel,
> you should try a few of the live-CDs out there, and see if they are able to 
> create a /sys dir.
>
>>  I have the I2C stuff and Hardware Monitoring sections in my Kernel all
>>  <M>odularized.
>> 
>>
>>  Have I over loked anything?
>> 
>>
>>  Nick
>> 
>>
>> 
>

