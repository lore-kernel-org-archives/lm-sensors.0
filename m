From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 08 May 2006 13:28:30 +0000
Subject: [lm-sensors] Fwd: Re: latest findings - my older posting from ~
Message-Id: <445F477E.2070707@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605071602.42069.dieter.jurzitza@t-online.de>
In-Reply-To: <200605071602.42069.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Raphael, please read whole thread about this problem with Tyan Tiger,
it seems we have just found a culprit that was causing SMBUS to hang ;)

> 80c0: 65 65 20 2c 2c 6c 6c 6c 65 65 44 65 28 4c 20 44

Hmm so the the device which was forcing the 0 was actually a smbus host
controller. This means that there is some hw bug in the chipset.

Jordan, plaease can you get it touch with the responsible person, so we can
track down the problem further?

> Thanks for helping - the hammering on the device by the loop you supplied was 
> very efficient ;-). The crash happened after about three hours or 20065 
> cycles of permanent reading.

Good. Now lets try same thing as I suggest in last mail but after the failure
please reprogram back the this values:

isaset -y -f 0x80c0 0x8
isaset -y -f 0x80c1 0x8
isadump -y -f 0x8000

if the both regs will read the 0x68 , then the bus may start to work again:
modprobe i2c-amd756
i2cdump ...
and see if it works...

Thanks,
Regards
Rudolf

