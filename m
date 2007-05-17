From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Thu, 17 May 2007 00:06:04 +0000
Subject: Re: [lm-sensors] [PATCH] k8temp - Add the diode offset to reported
Message-Id: <464B9C6C.9070403@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
In-Reply-To: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>Hello all,
>
>Amul Shah wrote:
>  
>
>>This patch adds support to include the CPU diode sensor offset when
>>reporting CPU temperature.
>>
>>Please see http://www.lm-sensors.org/ticket/2200 for the full problem
>>description.
>>    
>>
>
>Well I dont think this is correct. I believe that diode offset register is
>related to analog diode output not the digital sensor. Also I know that AMD is
>using my driver and did not make any changes. This leads me to a conclusion that
>the sensor simply does not work correctly and this error might be only
>compensated for analog part and not the digital. IIRC in some errata AMD states
>that the digital temperature sensor might be wrong and urges users to use the
>analog output.
>  
>

I think the digital sensor is just an embedded temperature sensor chip 
reading from a diode in a similar location to that of the analog diode.

In fact, some of the early Intel Xeon chips actually had Maxim 
temperature chips on the PCB substrate.  The Intel Xeon SMBus sensor 
spec was identical to an ADM1021 if I remember correctly.  They just 
marked some of the registers as "reserved" that otherwise had 
interesting information in them if you could identify the actual vendor 
that Intel chose that day to stick on the CPU substrate.

Clearly, this AMD digital sensor is not as transparent as that, but it 
is reasonable that the offset would need to be applied.

:v)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
