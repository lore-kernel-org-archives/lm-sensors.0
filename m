From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm77 on national sc1100
Message-Id: <1089198191.32259.139.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the late answer, I didn't receive your mail, just found
it in the mailing list archive.

Attached is a patch against 2.6.7-mm6, reworked to comply with your
comments. I chose to store the temperatures as `int' and not `s16'
because I store the converted values and eg. 80000 would hardly
fit in s16.

I guess it's time to admit that I've never written anything longer
than 10 lines in C before, so this is why it's going so slow. Thanks
for your time and patience :-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.7-mm6-lm77.patch
Type: text/x-patch
Size: 15506 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040707/1e3b1cb2/linux-2.6.7-mm6-lm77.bin
