From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: the lm_sensors-script
Message-Id: <20020904134728.U16408@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm not familiar with the /etc/init.d/funcitons file nor the 
dependancy of our project on it?


Phil

On Wed, Sep 04, 2002 at 09:53:22PM +0200, Christian Eyrich wrote:
> Hello,
> 
> I've gone through compiling the kernel, the i2c-drivers and the
> lm_sensors-package and also copied the scripts.
> But now I'm at a dead point in running the lm_sensors script on startup
> to load the required modules.
> 
> In this script another file /etc/init.d/functions is referenced to. I
> can't find such a file on my system. But it seems to be important since
> even after comment it out the script doesn't load the modules.
> 
> So would you please point me to where I can find the functions file?

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
