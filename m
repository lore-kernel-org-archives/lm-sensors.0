From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Thu, 28 Jun 2012 11:36:49 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FEC41D1.9070505@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com>
In-Reply-To: <4FEA4C10.2060904@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> All fans SHOULD spin at some low rate to make the system work.
>   
I disagree. When the outside temperature is low (say 10-12 degrees C) 
there is no need for the fans to spin at all. In fact, this is exactly 
what I have in my other PC - the box fan stops and only the CPU fan is 
operational at that time, which helps me save a bit on the electricity 
bill and reduces the noise.

> Alternatively, the BIOS may provide a kickstart, when there's rise of
> temperature over certain threshold, like you did in your script.
>   
Yeah, it should, but it doesn't, hence why I am using the driver and my 
script.

> I suggest you raise this issue with your board manufacturer.
>   
I did, but it seems they are a complete numpties - their "technical 
support" department is neither technical and they offer pitiful support, 
so I am left to my own devices so to speak.

> Sorry for my terrible english...
>   
No problem!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
