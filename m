From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Adapter driver
Message-Id: <20020521104044.F20703@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020520172349.A7186@crystal.2d3d.co.za>
In-Reply-To: <20020520172349.A7186@crystal.2d3d.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Mon, May 20, 2002 at 05:23:49PM +0200, Abraham vd Merwe wrote:
> Hi!
> 
> I've written an adapter driver an I'd like to have an ID assigned to me.
> This is what I'm using at the moment:
> 
> ------------< snip <------< snip <------< snip <------------
> root@crystal:~/lart/c++/src/i2c# grep FRODO
> /usr/arm-linux/linux/include/linux/i2c-id.h
> #define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
> ------------< snip <------< snip <------< snip <------------

Done.
 
> I've also got a couple of questions for you:
> 
> 1) Is there a developer mailinglist where I can discuss I2C related stuff?

Yes, I don't have the address handy, but here a link:

http://voxel.at/prj/i2c/

Look at the top of the Documentation section.  If it doesn't work, let
me know and I'll dig around some more.  We have a local list, too, for
sensors, but it's mostly administrative stuff for the project and not
a lot of technical discussion.
 
> 2) There is 3 fields in the i2c_algo_bit_data structure for timing: udelay,
> mdelay, timeout. What should I make this? I've made them 80, 80, 100
> respectively (stolen from Russell King's acorn RTC driver), but I'm not sure
> if this is the best selection...

Humm... I'll have to punt this to either Mark or Frodo.

> 3) Where do I send i2c patches to / can I get CVS access?

You can get CVS access from me.  Generate a password by running the
script in the sensors project, and email it to me:

doc/developers/genpasswd.pl


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
