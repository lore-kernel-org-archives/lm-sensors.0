From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Tue, 02 Jun 2009 22:15:03 +0000
Subject: Re: [lm-sensors] Power Supply Monitoring
Message-Id: <4A25A467.7090702@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
In-Reply-To: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/02/09 14:49, Jacob Steinberger wrote:
> Gents,
> 
> Before I get too far into lmsensors, I'm hoping I can get a quick  
> yea/nay on the path I'm going.
> 
> I'm trying to do power supply monitoring to detect if we're having a  
> problem (loss of grid power, loss of UPS power, voltage issues, etc).  
> I've found that some wiki pages state that this is, to some degree,  
> the point of lmsensors. What I'm failing at figuring out if I can do  
> this on my hardware or not.

I meant to copy my response to the lm-sensors list and missed it
the first time. Sorry for the duplicate.

With regard to the UPS monitoring, you would use something like
NUT for that: <http://www.networkupstools.org/>

With that, you can ask for all kinds of information about the
state of the UPS, including line voltage, etc. (depending on
the features of the UPS of course).

Note that I use NUT on Linux. I don't know if it runs on Windows,
but as you didn't mention your OS, I'm just taking a guess  :-)

I can't answer about whether your specific sensor chips are
supported by libsensors, so I'll leave that for someone else
to answer.

> 
> I've run sensors-detect, and I get back ...
> 
> Driver `coretemp':
>    * Chip `Intel Core family thermal sensor' (confidence: 9)
> 
> Driver `ipmisensors':
>    * ISA bus, address 0xca8
>      Chip `IPMI BMC KCS' (confidence: 8)
> 
> Driver `i5k_amb':
>    * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
> 
> Does either ipmisensors or i5k_amb support voltage type statistics? If  
> not, I would assume if my hardware does have these sensors, lmsensors  
> doesn't support them.
> 
> Thanks in advance for any responses (or lack there of ;),
> 
> Jacob
> 
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
