From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: I2C displays
Message-Id: <20020411184453.N31673@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <005e01c1e1be$cbcf7090$23fb3491@aangel>
In-Reply-To: <005e01c1e1be$cbcf7090$23fb3491@aangel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, thanks for the note.  As a matter of fact, there is some basic
support for the Matrix Orbital displays.  I wrote a basic driver which
lets you do some simple stuff through a /proc file.  It might be
more flexible to access the device more directly by using the /dev
interface to the I2C bus, though, if you want more control.

Anyways, yes, the support is there.  btw-I think using the I2C bus is
a little cleaner than using a serial interface for the displays, imho. 


Phil

On Fri, Apr 12, 2002 at 03:10:06AM +0200, PE1SBH wrote:
> Hi there, I admire your programming skills and I'm heavily busy remoddeling mobo's (now my dual abit bp6 board). I saw the I2C architecture in it, and thought.. what?? Why not using that?? So I have some thought about adressing a LCD module via I2C bus.
 Can you support I2C displays as Matroxorb? And just plain displays which are connected (4bits/8bits) to the I2C bus with an I2C->par converter such as (for example) philips PCF8576? I2C adressing is a much improvement above parallel, speed and int load a
re just superior to par/ser adressing. When more people starting to realize that (perhaps you can support/mention it on your page?), much people will do it that (I2C) way because they want to save cpu cycles :-)
> 
> Thanks for all, you're a great motivator to get me back on developing more (computer based) hardware.
> 
> Sencerely,
> Alex.

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
