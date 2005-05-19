From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503202345430.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I would like to have a question to ABIT:

Is SMM (system management mode) code accessing SMBus cotroller?
If so what are the algorithms when bus/controller is not ready?

What we have seen with bit 6 set could lead to following:
that some code did a kill transaction or device reset. Because It wasnt
our driver only thing that is left is SMM.

To proposed driver change:

Please can you try to implement some bus recovery from this situation even
if it is now somehow working? (like kill transaction after a while etc)
and not just blindly exit hoping that error does not matter.

Any other opinions?

Thanks

regards

Rudolf
