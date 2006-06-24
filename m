From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 24 Jun 2006 12:30:06 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <449D304E.5070603@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Axel,

I'm attaching a script that creates snapshots from SVN. It seems there is no
crontab available on the server, so I'm asking you kindly to run it somewhere.

The script is fairly simple, it just needs to know the target dir, plus the dir
where will be the script/temp repo placed. Check first few lines of script please

It may be executed with lm-sensors or i2c as parameter. We would like to have
daily snapshots for lm-sensors and weekly for i2c if possible.

I tested the script briefly and it seems to work.

Thanks,
Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: do_snap
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060624/ecb2a3d5/attachment.pl 
