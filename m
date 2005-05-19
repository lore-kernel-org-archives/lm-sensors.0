From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Are sensors for redundant PSU's?
Message-Id: <3F662AF2.4080605@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6628EC.7060203@pocock.com.au>
In-Reply-To: <3F6628EC.7060203@pocock.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Short answer: no

Long answer: It depends on the hardware.  In general, there aren't 
sensors in PSU's which we can access, but there are some power supplies 
which have fan-speed monitors and/or temp sensors which we can 
potentially read.  I'm not aware of any PSU fault sensor which is 
supported by an open-source project, but that doesn't mean that it 
doesn't exist.  It may be the kind of thing which only can be accessed 
through a bios interface.

If I were you, I'd get some technical details on how the fault detection 
on some rack-mount servers works.  If you are lucky, they may actually 
disclose enough details to write a driver, or have some sort of driver 
already available.


Phil

Daniel Pocock wrote:

>
> I am about to buy a rack server with redundant PSU's.
>
> Will lm-sensors tell me if one of the PSU's fails?  Or should I be 
> looking at other software to monitor PSU failure?
>
> Alternatively, if such support isn't featured in lm-sensors, is this 
> something I could code myself?
>
> Regards,
>
> Daniel
>
