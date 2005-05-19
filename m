From: geoff.leach@bigpond.com (Geoff Leach)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: W83627THF and fan speed
Message-Id: <4072B12D.2090200@bigpond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <40721FE7.40504@bigpond.com>
In-Reply-To: <40721FE7.40504@bigpond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>I've just upgraded to 2.6.5 and saw that it has a driver for the
>>Winbond W83627THF. Now I get some sensor values. Thanks.
> 
> 
> You're welcome.
> 
> 
>>My temperature and voltage readings look ok, and are a good match for
>>the values reported by the BIOS. However, my fan values are all 0 
>>whereas the BIOS reports them generally in the range 1000-2500 rpm.
> 
> 
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section%204.1
> 
> "4.1.1 Fans sometimes/always read 0!!
> 
> You may need to increase the 'fan divisor'. See doc/fan-divisors in our
> package for further information."
> 
> Set divisors to 4 or even 8 and you should get the readings. This is
> done by adding lines of the form "set fan1_div 4" in the "w83627thf-*"
> section of /etc/sensors.conf, and running "sensors -s" to apply the
> changes.
> 


Thanks, that fixed it.

I actually did look at the FAQ beforehand, and saw that entry there. But 
I only tried the values 1,2 and 4 - seems I need a value of at least 8.
