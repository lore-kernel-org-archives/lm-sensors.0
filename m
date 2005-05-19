From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: lm-sensors feedback for via686a
Message-Id: <20040420230212.7bb197a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <004201c42713$bdbdf020$1701a8c0@omdell>
In-Reply-To: <004201c42713$bdbdf020$1701a8c0@omdell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I would like to report my findings regarding the motherboard I use
> lm-sensors with; in case it can be of any help.  I did find some info
> on the net to help setting up my system.  However, the most relevant
> comments where in the sensors.conf file and here are my own :
> 
> motherboard, chipset and processor:
> Gigabyte GA-7ZM rev2.21 (Socket-A) KT133 VT82C686A (thunderbird
> 850mhz)
> 
> just like Johannes, my temp1 is the CPU and temp2 is the SYS
> temperature

I've added that as a comment to the default configuration file, together
with another Gigabyte motherboard.

> my temp3 is not displayed in the bios nether
> 
> my 2.5V sensor also reads near 0 value and does not appear in the bios

This seems to confirm what other people are reported so far (temp3 and
2.5V have ready-to-uncomment ignore lines).

> my vcore value is around 1.73V (manual shows bios screen shot with 1.6
> value)

This depends on the CPU so we cannot write anything about this in the
configuration file.

> I hope these information will be useful

Yes, thanks for reporting.

FYI, I recently noticed that the voltage conversions were not correct,
resulting in theoretically slightly lower readings than should have be
(when compared with what the BIOS says, for example). Had you noticed
this? This is fixed in lm_sensors CVS for 2.4 kernels, and there is a
patch pending for 2.6 kernels, here:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.5-mm3-i2c-via686a-2-in-values.diff
Feel free to give it a try and tell us how it works for you.

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
