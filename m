From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: ATXP1 kernel patch
Message-Id: <Pine.LNX.4.58.0504091809380.2186@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

We are very sorry, we missed that ball is on our side.

Recently I found that ATXP1 register documentation was made
public. Or is public by mistake :)
http://www.attansic.com.tw/english/products/pdf/ATXP1_1.1.pdf

I went through your 0.6 version and I generally agree with it.

Except the static inline int reg_from_vid(int val, int vrm)

We would like to have name:

vid_to_reg(int val, int vrm)

Please can you fix the name and post a patch only containing the i2c-vid.h
changes to: greg@kroah.com and CC to sensors@Stimpy.netroedge.com
Do not put the patch to attachment let it be part of your message.
Please include short (one sentence) desciption what it does.
Dont forget the Signed-off-by: Sebastian Witt <se.witt@gmx.net>

As for the driver, I think it is ready too. Repeat above for the driver,
just note in the email that it depends on previous patch.
(and dont forget to fix the function call :)

Create both patches for latest kernel (-mm- tree is enough).

Thank you.
Sorry for the delay.

Regards

Rudolf
