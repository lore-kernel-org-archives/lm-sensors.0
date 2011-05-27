From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 May 2011 17:24:00 +0000
Subject: Re: [lm-sensors] Coretemp CPU support documentation
Message-Id: <1306517040.2163.570.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDF723B.5060008@gmail.com>
In-Reply-To: <4DDF723B.5060008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-05-27 at 05:43 -0400, Arseny Klimovsky wrote:
> Hello, list
> 
> There is incorrect information about required kernel version for 
> coretemp to work on the page http://www.lm-sensors.org/wiki/Devices
> 
> For example I have Core i3 550, but it doesn't work with 2.6.32 
> (coretemp: Unknown CPU model 25), a newer kernel is required (I tested 
> 2.6.38).
> 
> So, I suppose it's better to use CPU model (0x25) or other stable 
> information, but not marketing name (Core i3) for this table.
> 
i3-550 is a Clarkdale core, which came after Lynnfield (which was added
in 2.6.32, as mentioned in the wiki). Generic CPU temperature sensor
detection was added in 2.6.35. I'll add a comment to the wiki.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
