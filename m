From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c patch out of 2.6.4-rc1-mm1
Message-Id: <1078150396.404344fc41690@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew, hi Greg,

I just saw that the i2c stuff from Greg's tree have been backed out
from 2.6.4-rc1-mm1. Quoting the release notes:

"bk-i2c.patch was dropped pending it getting its lmsensors act
together."

I don't quite understand what I am (well, what we are...) supposed to
do (actually, I do not even get the meaning of the sentence itself). I
clearly exposed my reasons for an interface change and as far as
I know, nobody objected to that particular point.

The only complaint we got was from Mike Fedyk, and does not
concern the kernel part directly. He simply thinks that libsensors
should support all 2.6 kernels, while I think it's not worth it. This
is not fundamentally linked to the i2c interface change that was in
2.6.3-mm4, since the problem already exists with all versions of the
kernel starting from 2.6.0 (lm_sensors 2.8.2 only supports Linux 2.6.0,
lm_sensors 2.8.3 only supports Linux 2.6.1, lm_sensors 2.8.4 only
supports 2.6.2). So, whether my interface change proposal is accepted
or
not, Mike's objection already applies.

So I don't think that Greg's i2c stuff should have been backed out from
Andrew's tree just because of Mike's objection. If we were to accept
Mike's objection (which I do not plan to do at the moment, but I may
change my mind if more people agree with him), the changes would take
place in libsensors, not in the kernel source tree anyway.

If there were other objections I am not aware of, please let me know.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
