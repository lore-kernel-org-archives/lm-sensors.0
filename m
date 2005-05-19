From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Fw: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503261123550.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have two questions here:
> (1) As we know, it will be very inconvenient for those users with ASUS
> NCLV-D motherboard and want to use w83792d driver under linux-2.4, if they
> have to write the value "0x08" into "0x04b9" by themselves each time.
> So I wonder whether the related bus driver has been modified so that users
> can use w83792d driver easily? Will the coming lm_sensors-2.9.1 fix it?

Hmm I must talk with Jean on this. I cant provide authoritative answer.
Yes, to "fix" the bus driver is one solution. I completly hate the hide
and seek idea it is really stupid.

> (2) How about the problem of uploading eeprom? Need uses have to upload the
> eeprom by themselves? Or this problem also has been fixed?

Yes it is fixed in CVS. The i801 block transfers are disabled in the
driver again, but classic I2C reads works for eeproms too. So with new
version of lm_sensors this issue is not in question.

Regards

Rudolf
