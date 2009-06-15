From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Jun 2009 19:36:59 +0000
Subject: Re: [lm-sensors] VID on Intel Core Duo
Message-Id: <20090615213659.4c22006f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
In-Reply-To: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Maneki,

On Sun, 14 Jun 2009 00:36:11 -0400, Maneki Neko wrote:
> I'm trying to obtain the VID on an HP notebook with a Core Duo CPU.  Under
> Windows, I could see the voltage, speed, temperature, etc. but with
> lm-sensors all I'm able to see is the temperature.
> 
> I have run sensors-detect to no avail.  Can anyone provide any advice to me
> on how to get this working?  Thanks for your time and help!

What tool do you use on Windows? Does it tell you which chip is used
for monitoring?

How many voltages are displayed? If there's only one voltage, is is a
measured one, or the VID value?

CPU speed you can get from /proc/cpuinfo, it's not lm-sensors' job. Of
did you mean fan speed?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
