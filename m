From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: hi
Message-Id: <20020918145038.E20006@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org




On Thu, Sep 19, 2002 at 01:20:02AM +0200, nerula wrote:
> Hi
> i need sensors to monitor the temperature of my cpu, but i'm not able to understand why
> it doesnt work with my RH 7.1 on 2.4.18
> I have a winbond sensor chip, when i load the modules i2c-core, i2c-dev, i2c-proc

Those are good, but you also need a bus driver(s) and chip driver(s).  
Get the latest Lm_sensors package (and upgrade your i2c package as
needed) and run 'sensors-detect' for a suggestion of which drivers to
use for your computer.  Your rpm 2.5.5 is old.  See our site:

http://www.lm-sensors.nu/


Phil

> here the output:
> 
> [root@localhost nerula]# sensors   
> No sensors found!
> 
> Why? Does it mean that my sensor isnt recognized or that i miss todo something?
> It doesnt work yet with -s or -u option.
> The rpm is ver 2.5.5.
> Thanks, bye!
> 
> -- 
> LINUX USER #250527

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
