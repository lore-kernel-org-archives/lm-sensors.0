From: bradley@greystate.com (Bradley Schatz)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <1084367766.4429.19.camel@angel>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean.

> Aha, it wasn't meant to be a smiley. I just missed the opening
> parenthesis. Glad it helped anyway. However this means that your fan is
> really, really slow. Maybe this explains why your system is so hot?
> 
> >> As hot has hell! Hardly believable. Maybe you need to change the sensor
> >> type?
> >
> >Changing the sensor type starts to give negative temperatures.
> 
> Hm OK, so they had to be correct in the first place.
> 

Could it be that the fan is not being driven fast enough by bios/io chip
settings? Or maybe the CPU fan is just a little flaky. Any ideas?
 
It is a Gigabyte GA-7VKML motherboard. VIA KM266 & VT8233A + IT8705F.

> > The it87 & lm90  M/B temp are starting to agree.
> 
> It's both encouraging (means we are probably measuring the temperature
> correctly) and frightening (would your system need additional fans?)
> 
> > However the it87 CPU temp looks almost 2X the lm90 one.
> 
> This is odd. Do you have any conversion formula set in the configuration
> file?
> 

I checked and this was a part of the problem. It looks like it still may
need some tweaking.

Cheers,

bradley

