From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 20 Aug 2005 23:59:57 +0000
Subject: [lm-sensors] Abit Uguru driver status update
Message-Id: <4307A807.60202@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've contacted Olle Sandberg (the author of a userspace program), and 
hasn't made any progress beyond the reading of sensors value only (which 
is a great achievement by itself).

He did write an lm_sensors chip driver todo this, using the same 
algorithm as his userspace program. He has mailed me a copy of this chip 
driver. His driver and mine offer the same functionality. They do 
ofcourse have subtile differences.

After writing the kernel module, he hit the same problem as me: we also 
need to add support for this to libsensors. I know that this is easy 
todo (I've already taken a small look). He has however sorta lost 
interest, to quote him: "I have had no time (or loss of inspiration"
and: "If you want and got time for it you are free to finish the driver"

So I've mailed him that I will move ahead with my own version of the 
driver (as I know that one better) and add libsensors support. I've also
told him that any help is ofcourse very welcome and the he will get 
proper credit for doing the hard work!

So now I would like to request an ID for the abituguru driver. Also any 
comments on my previously posted driver are more then welcome.

Thanks & Regards,

Hans
