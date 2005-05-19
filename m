From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1089019483.3224.9.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2004-07-03 at 09:01, Jean Delvare wrote:

> Ahhh correct, I missed these. Thanks for the fix, I applied it. If you
> get confidence 6 with this changes, it's all OK.

Yes, I get confidence 6 with CVS sensors-detect now.

> Next steps:
> 1* Update detection in lm75 driver and docs (CVS/2.4).
> 2* Update detection in lm75 driver and docs (2.6).

I see in the CVS that the detection in the 2.4 module has
already been updated. Should I port it to the 2.6 module,
or has someone else already done that?

> 3* Complete your lm77 driver and submit it for integration into Linux 2.6.

Attached is a new version that has improved detection (mostly based on
the sensors-detect script). It works here (and I see no reason why it
shouldn't work at anywhere else), but could use some testing, especially
against lm75 sensors.

Please let me know what else can I help to get this driver into the
kernel.

Thanks,
Andras


-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm77.c
Type: text/x-csrc
Size: 11218 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040705/33917938/lm77.bin
