From: Sadin Selmani <sadinselmani@gmail.com>
Date: Sat, 03 Nov 2012 04:13:33 +0000
Subject: Re: [lm-sensors] Temperature reading too high for it87
Message-Id: <loom.20121103T050316-869@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
In-Reply-To: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry if I'm posting in the wrong mail-list, but I have a similar problem worth 
noting.

As for my temp sensing, I think the senors are cheating. It simply reflects CPU 
usage and scales it to a temp. Either that, or my CPU is running SUPER COOL, 
which is highly unlikely. See for yourself.

http://s8.postimage.org/w5wigedxh/sensors.png
http://s17.postimage.org/t68xgqn4f/Psensor_Temperature_Monitor_005.png

These Screenshots were taken during a small battery of burn-in tests which ran 
all 4 of my cores at 100%. See 
[URL="http://www.roylongbottom.org.uk/linux%20burn-
in%20apps.htm#anchorStart"]this[/URL] for more details.
For comparison, BIOS looks WAY more realistic (and scary).

http://s14.postimage.org/u3m74ntbl/2012_11_02_23_08_00.jpg

After reading [URL="http://www.mjmwired.net/kernel/Documentation/hwmon/k10temp"] 
this, it almost appears like the KERNEL driver "k10temp" is the culprit since it 
kind of explains what's happening with temp sensing. Time to file a bug?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
