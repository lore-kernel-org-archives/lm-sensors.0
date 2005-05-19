From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <408A8C56.2070908@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

even if he increases the fan divisor so he doesn't get 0 anymore,
fan readings don't have a lot of resolution, so the values
might be 4111, 4221, 4309, etc., so I can see where
interpolation could be misleading.

Aurelien Jarno wrote:
> On Fri, Apr 23, 2004 at 01:32:40PM +0200, Mario 'BitKoenig' Holbe wrote:
> 
>>Well, this depends a lot on the values you get from the sensors
>>and on the interpretation of them.
>>For example, I have a machine whose fan is reported with 0 RPM
>>from time to time, while it normally operates around 4200 RPM.
>>With interpolation I get something like 70 RPM stored in the
>>rrd instead of the - real - 0, which shows a very different
>>view in the rrd than in reality.
>>
>>The question is more or less: does the spotlight that sensord
>>points at one moment say something about the values of the
>>sensors in the past?
> 
> 
> We have different points of view. For my part values comming from 
> sensors are changing slowly, that's why interpolation is not a problem,
> and is even better. 
> 
> You seems that your fan's sensor changes very often. It is surely due to
> a fan_div not properly configured. Try to multiply the fan_div 
> corresponding to you fan by 2 or 4. For more information, have a look at
> /usr/share/doc/lm-sensors/doc/fan-divisors
> 
> With this problem solved, the interpolation should not be a problem
> anymore.
> 
> Bye,
> Aurelien
> 
> 
