From: roger@planbit.co.uk (Roger Lucas)
Date: Tue, 01 Nov 2005 00:21:26 +0000
Subject: [lm-sensors] LM-Sensors for VT8231with 2.6.14 kernel
Message-Id: <20051031232026.EE66212E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am trying to get the full sensors support on my Via Eden 5000 MoBo.  I was
running it with Debian Sarge on 2.6.8 and had the vt8231 driver running OK.
For various reasons I want to upgrade to the latest kernel (2.6.14) and so I
have compiled this from the kernel source and am trying to get the sensors
running again.  There is no vt8231 driver in the kernel source release, so I
have done some digging to try and work out what is going on.

 

The whole API situation seems confusing.  Looking at the code provided with
the kernel for drivers such as the vt686a, there seems to be a lot of
differences in the API between this code and the code in the latest daily
snapshot on the lm-sensors site.  There is documentation with the kernel
source "Documentation/i2c/porting-clients" that seems to describe these
changes, so there is information to work with, but before I start writing
some C code to port the vt8231 driver to the new API, I would like to make
sure that I am heading in the right direction and that nobody else is
already working on this.

 

Can anyone give me a quick update on what is happening with the vt8231 hwmon
driver (and even if it is still required and not replaced by something else)
?

 

Thanks,

 

Roger
