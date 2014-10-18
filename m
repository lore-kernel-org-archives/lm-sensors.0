From: R Kimber <richardkimber@btinternet.com>
Date: Sat, 18 Oct 2014 11:59:58 +0000
Subject: Re: [lm-sensors] Can't load it87 module [solved]
Message-Id: <543EB887005BEDD5@rgout02.bt.lon5.cpcloud.co.uk (added by postmaster@btinternet.com)>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Oct 2014 13:36:08 +0100
R Kimber wrote:

> 
> I'm using Ubuntu 14.04 with 3.13.0-37-generic. MB is Gigabyte Z97X-UD3H
> LGA1150; CPU is i7 4.0GHz.  I have installed 1:3.3.4-2ubuntu1 version of
> lm-sensors. Sensors-detect indicates I have a chip of the ITE family:

I now have the solution for this:-

sudo modprobe --verbose it87 force_id=0x8620

-- 
Richard Kimber


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
