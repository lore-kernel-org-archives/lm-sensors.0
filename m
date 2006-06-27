From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 27 Jun 2006 10:51:45 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060627105145.GH4718@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Jun 24, 2006 at 02:30:06PM +0200, Rudolf Marek wrote:
> I'm attaching a script that creates snapshots from SVN. It seems there is no
> crontab available on the server, so I'm asking you kindly to run it somewhere.
> 
> The script is fairly simple, it just needs to know the target dir, plus the dir
> where will be the script/temp repo placed. Check first few lines of script please
> 
> It may be executed with lm-sensors or i2c as parameter. We would like to have
> daily snapshots for lm-sensors and weekly for i2c if possible.
> 
> I tested the script briefly and it seems to work.

I've setup snapshots at

http://dl.lm-sensors.org/{lm-sensors,i2c}/snapshots/

They are checked daily, but only generated if there is an actual
change. I'm keeping the last 32 snapshots of both sub-projects.

I've manually initiated snapshots right now, and the scripts are
running at 06:00-06:10 CET

We can tune any parameter you like (cron frequency & time, URLs,
number of snapshots to keep etc).
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060627/89521a93/attachment.bin 
