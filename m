From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: LM85
Message-Id: <3E4D415F.5E6CD76E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4.3.2.7.2.20030211181355.00b62100@mail.dns-host.com>
In-Reply-To: <4.3.2.7.2.20030211181355.00b62100@mail.dns-host.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Margit Schubert-While wrote:
>
>         I'm still looking at what we can get out of all these registers.
>         Give me another week to get this in some sort of shape.
>         There are a couple of things that Intel seem to have changed :-(
> 

ok

>         Can you E-Mail your E-address to margitsw@t-online.de
>         and, as soon as I have something that's compatible, I'll
>         send it. I'd prefer to get the driver to 90% complete before we shove it
>         into CVS.
> 

my address should be on the from: line of this mail

>         Two things :
>         1)  Can you reserve an I2C device Id (and E me)

will do 

>         2)  Do I have to dig through the sensors and related
>              progs myself or can somebody take that over ?
> 

we can do any part of it you like, just let us know.

>         sensors-detect just needs the trivial change from
>                 driver => "Unwritten: lm85",
>         to
>                 driver => "lm85",
> 

we'll do that when we check in the driver

>         Should have mentioned in my original mail that I'm using 2.7.0
> 

that's fine, there are some things changing in CVS, you may wish to
look at the CVS version of the driver you started from for clues,
but if not we will do that.

>         Cheers
> 
>         Margit
