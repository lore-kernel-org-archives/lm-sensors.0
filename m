From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503240016310.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Could you give me more information on how to "kill transaction after a
> while"? I tried, but failed, maybe the codes I tried is not correct.

Well thats hard without a datasheet. Maybe Patrick can do sometning like
this I guess it is like two more lines of code. I'm not an expert of this
subject. Maybe you can take a look to your windows driver sources
if there is some problem recovery after a transaction and not just
before as it is in ours.

LHHsu:

Please can you try to ask for that SMM mode question? If something is
using the SMBUS controller we should know it.

Thanks

Regards

Rudolf
