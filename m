From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: lm_sensors2/doc/chips mic74
Message-Id: <gqUFWjmh.1107340522.3506030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark & all,

On 2/2/2005, "author@mordac.netroedge.com"
<author@mordac.netroedge.com> wrote:

>Added Files:
>	mic74
>Log Message:
>(mds) lame attempt at a doc

I don't see the point in having a kernel driver for this. The driver
currently exposes all the registers directly to procfs, with arbitrary
names. You could achieve the same goal with a user-space program relying
on i2c-dev. I guess that this device is meant for a very specific use
anyway.

Thanks,
--
Jean Delvare
