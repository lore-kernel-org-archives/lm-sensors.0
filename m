From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503091003310.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Would you please try again with debugging enabled?
(same case as we did for i801)

Some steps:

1) reboot/halt, modprobe w83792d, copy logs
2) reboot/halt, sensors-detect, copy logs
3) modprobe w83792d, copy logs

Regards

Rudolf
