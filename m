From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: FW: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503261117200.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Can you tell us which linux kernel versions can use this patch hide_and_seek_2 ?
> linux-2.6.10? linux-2.6.11? and ...?

I think it should apply to 2.6.11 but it should work for 2.6.10
with messagess like "Hunk #x succeeed at with offset"

> And from which kernel version we need NOT patch it, because that version +
> has contained your codes?

Not yet in kernel. We must first know if it really works. Then we must
make a patch cleanup. We have also other person with your chip, but also
ASUS board and also hidden. This trick does not work. (Maybe you noticed
the mails with subject "asus new hope". I will write about this in other
email.

If you tell me that it works. I can prepare patch for mainline kernel.

How:
you should see in logs the line from the patch and if you ran
i2cdetect on the bus you should see your chip address "responded"
Or you can try sensors-detect it should detect the chip without your
driver. So you can test it before your driver is ready.

Regards

Rudolf
