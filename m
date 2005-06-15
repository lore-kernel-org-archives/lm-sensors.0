From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 15 Jun 2005 18:24:15 +0000
Subject: [lm-sensors] RE: w83792d.c with linux kernel 2.6.11 on asus
Message-Id: <42B055A4.8010501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E722A@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E722A@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
> 
> Jean, Rudolf,
> Do you have any suggestion?

We can try to scan the bus again.

Please can you modprobe your  i2c bus driver i2c-i801 (most likely)
and run i2cdetect 0 and send the output to us?
After running the command please run the isaset command
and repeat i2cdetect 0

Then reboot the machine because the isaset trick is blind shot to some GPIOs.

> Btw, the 792 driver has not been fully tested by me under x86_64 platform,
> but I do NOT think this is the reason.

Yes I think that ASUS have it switched.

>>When i insert i2c-isa and w83627thf i get some readings
>>(just some voltages, 0rpm fans and -48v temperatures)
>>but i know the board also has a w83792d for sensors!

ASUS usualy "forks" the bus so we must now contact Asus and ask them. This will take some time so please be patient.
In meanwhile please try what I suggested.

Regards

Rudolf
