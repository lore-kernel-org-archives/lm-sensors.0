From: riku.voipio@iki.fi (Riku Voipio)
Date: Sun, 15 Oct 2006 20:46:19 +0000
Subject: [lm-sensors] Fintek F75375S/SP chip driver
Message-Id: <20061015204619.GA10535@kos.to>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Attached driver has only been tested on a Thecus N2100 system. Voltage, 
temperature and fan measurement works. I've only implement manual
fan control so far. The automatic modes appear a) too complex for a
newbie like me b) wouldn't work reliably on N2100 anyway as the fan 
speed sensor seems to give a very rough estimate at best.. 

F75373 is almost identical according to datasheets[1], atlest for all
the register this driver uses, so I enabled identifying it in detect.

Cheers,
Riku (CC: me I'm not on the list)

[1] http://www.fintek.com.tw/eng/products.asp?BID=4&SID=5

-------------- next part --------------
A non-text attachment was scrubbed...
Name: f75375s.c
Type: text/x-csrc
Size: 21745 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061015/3728d6e3/attachment.bin 
