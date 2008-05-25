From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 25 May 2008 21:20:40 +0000
Subject: Re: [lm-sensors] Future plans for sensors-detect
Message-Id: <4839D828.1010900@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080521114013.074cde02@hyperion.delvare>
In-Reply-To: <20080521114013.074cde02@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> For completeness...
> 
>> I was also thinking that user-friendly distributions might want to
>> automatize the process of setting up the sensors as part of the system
>> installation. There are many improvements needed before this can
>> happen, such as a command line interface / non-interactive mode to
>> sensors-detect and DMI support, but speeding up the detection itself
>> would also help, I think.
> 
> Note: when sensors-detect goes non-interactive, you are more likely to
> notice how slow SMBus probing is. For now, most time is wasted waiting
> for the user to answer questions, so you don't really notice, unless
> you're using HZ0.
> 

Are you really planning on doing non interactive i2c probing from the 
initscript? To me that feels wrong:
1) Only 101% safe probing should be done non interactive
2) Even if we can safely determine which hwmon drivers should be loaded,
    we still should not load them without also having a valid
    matching motherboard sensors.conf

The reason for 2 is that its better to show no readings to an uneducated users 
then to show wrong readings which make him/her think his/her machine is about 
to blow up.

>> I wouldn't consider it if the patch was intrusive, but it's pretty
>> small if you look at it.
> 
> After removing the word register cache (recent changes to the script
> make it hardly worth caching word reads) and the instrumentation code,
> the patch only adds 8 lines of code. The diffstat reads:
> 

I guess its worth it then :)

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
