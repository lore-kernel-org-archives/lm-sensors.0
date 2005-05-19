From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503261611110.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I changed error handling of the ali1563 I think it can work this way.
Please fix error(s) in source if you spot any, you will see the main idea.

If it is working please can you try to load eeprom modules to probe block
transfers? I only hope ASUS is not playing hide and seek right now :(

Just run sensors command or take a look to eeprom content in /sys ...

Thanks

Regards

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-ali1563.c
Type: text/x-csrc
Size: 12422 bytes
Desc: here it is
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050326/524cc9f6/i2c-ali1563.bin
