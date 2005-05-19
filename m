From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <Pine.LNX.4.58.0503051224040.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a solution. Block reads to eeprom are locking the bus.
Please use CVS version of lm_sensors or do NOT load eeprom module.
Then it should work. Please note you need to do the isaset trick.
I will work on quirk.c to kernel this weekend.

Regards

Rudolf
