From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Problems with lm_sensors & Asus A7V
Message-Id: <20020515092551.D18192@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Can you do this (with the modules loaded)?

cd /proc/sys/dev/sensors

cat chips

ls *

If not, then you are missing some basic support in the kernel for
/proc, I would guess.


Phil


On Wed, May 15, 2002 at 05:50:49PM +0200, Sven Voigt wrote:
> Hello!
> 
> Sorry to bother you, but even by reading INSTALL and the FAQ I can't manage 
> to get lm_sensors working correctly. That is, sensors-detect in fact.
> 
> There are lm_sensors and i2c running in version 2.6.3 on Asus A7V as self 
> compiled kernel (2.4.16) modules. It even detects Via686A and AS99127F 
> correctly. But after loading the approriate modules (i2c-viapro & w83781d), I 
> run 'sensors -s' that prints
> 
> as99127f-i2c-0-2d: Can't access /proc file for writing
> Run as root?
> 
> Yes, it's run as root and i2c-proc is loaded, too. So, what now?
> 
> Thanks for any help in advance and Cheerio
> -- 
> Sven Voigt, Mainz, Germany                                 http://www.ps90.de
> 
> "I am looking for a challenging graphics adventure, that thrills me."
> "Did you give Windows XP a try?"
> 
> (Before replying, *please* http://learn.to/quote - thank you!)

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
