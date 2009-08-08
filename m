From: Reimundo Heluani <rheluani@gmail.com>
Date: Sat, 08 Aug 2009 03:55:24 +0000
Subject: Re: [lm-sensors] Can't load w83627ehf for Windbond W83667HG-A
Message-Id: <1249703724.3159.5.camel@campari.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1249703390.3159.2.camel@campari.homeip.net>
In-Reply-To: <1249703390.3159.2.camel@campari.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please disregard my previous message as I obviously should've checked
that the wiki says this chipset is supported since 2.6.30, will try that
kernel

Thanks, 

R.



hello, I am trying to check temps and speeds on an Asus p5q3 deluxe. It
has the Winbond W83667HG-A chip and sensors-detect finds is as W83667HG
so that I should load the module w83627ehf. But modprobe cries with "No
such device"


running vanilla 2.6.29.5 kernel on an LFS system. No problems with
coretemp module, reads cpu temps without trouble. Is this chipset
different than W83667HG (no -A)? or is my setup the one with trouble?

Thanks, 

R.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
