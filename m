From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Wed, 03 Jun 2009 14:31:21 +0000
Subject: Re: [lm-sensors] Power Supply Monitoring
Message-Id: <4A268939.3060309@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
In-Reply-To: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/02/09 20:09, Jacob Steinberger wrote:
> My hope is that if one power supply is no longer working, thus no longer 
> producing any DC output, I could alarm on that value being 0. Again, 
> this is just a hope.
> 
>> UPSes tend to have various amounts of AC power monitoring available,
>> and that might be a better place to look.  Network UPS Tools
>> http://www.networkupstools.org/ runs on Linux and can talk to many
>> types of UPSes.
>>
> Tend to, but since the guy that does the monitoring rarely has the 
> ability to make the purchases of said device, you tend to end up with 
> old refurbished devices that don't have the ability to be monitored 
> without a laptop and a console cable.

You seem convinced that NUT won't work. I'm not sure why you've
come to this conclusion. Perhaps you've researched NUT lately
and found that it doesn't support any of the UPSs you're using.
Of course, that would have to be pretty bad luck, as NUT supports
many (most?) of them.

> 
>> Beyond that, the next step is usually to go to the site and look for
>> any obvious problems - do half the machines reboot when the machine
>> shop downstairs fires up the arc welder?  Did somebody set up 42U of
>> servers on a 100 foot 16 gauge (30 m 1.0 mm^2) extension cord?  Then
>> you start poking at it... depending on how subtle the problem is and
>> your budget, you start with a $30 Kill-a-Watt meter, then move up to
>> a $200 Fluke multimeter, and then maybe a multi-thousand-dollar Fluke
>> or Dranetz data logger.
>>
> I'm really just looking for a way to do a simple function check on the 
> power supplies to detect when they're operational. Not necessarily to 
> find out what voltage is going through, but to see if it's even working 
> or not. For example, we have one power supply on grid, the other is on 
> UPS - the easiest way to detect if there's a problem with UPS or grid 
> power is to monitor the power supplies on the boxes. This would function 
> as a dual monitor if there was ever an issue with just a power supply.

How do you expect software on a computer to tell you when the power
supply on that computer has gone to zero volts?


> 
> Jacob
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
