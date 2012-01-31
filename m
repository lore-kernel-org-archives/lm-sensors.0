From: David Kremer <david.kremer.dk@gmail.com>
Date: Tue, 31 Jan 2012 11:59:57 +0000
Subject: Re: [lm-sensors] pwmconfig and fancontrol don't work in ubuntu 10.11 archlinux kernel 3.2
Message-Id: <4F27D7BD.9060707@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010009090503040508070508"
List-Id: <lm-sensors.vger.kernel.org>
References: <4F27026A.4080904@gmail.com>
In-Reply-To: <4F27026A.4080904@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010009090503040508070508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> There is a bug in the upstream driver affecting the number of fans
> detected for NCT6776F. You can try a possible fix by loading and
> installing the driver from
> https://github.com/groeck/w83627ehf/archives/testing.
>
> No idea if that helps, though. The bug has always been there, so I have
> no explanation why it might have worked with archlinux 3.0 LTS.
>
> Guenter
Hi, thank you for your answer. I am actually logged into archlinux with 
"linux LTS 3.0.17". I suspect that maybe the bug you outlined has been 
corrected in this branch. I stay at you disposal if ever you want to 
investigate this furthermore.

However, there is some kind of bug with the CPUTIN and the AUXTIN which 
I don't understand. Why the CPUTIN from the nct interface is so high 
(around 75 Celsius degrees) since the coretemp interface (which I 
believe is working) gives me 35 Celsius degree for the CPU temp ?

Guenter, I am going to test your driver under various configuration, and 
see if changes happen. Then I will report you new problems I detect.

David


--------------010009090503040508070508
Content-Type: text/plain; charset=UTF-8;
 name="sensors-output.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sensors-output.txt"

Y29yZXRlbXAtaXNhLTAwMDAKQWRhcHRlcjogSVNBIGFkYXB0ZXIKUGh5c2ljYWwgaWQgMDog
ICszNC4wwrBDICAoaGlnaCA9ICs4Mi4wwrBDLCBjcml0ID0gKzEwMi4wwrBDKQpDb3JlIDA6
ICAgICAgICAgKzMxLjDCsEMgIChoaWdoID0gKzgyLjDCsEMsIGNyaXQgPSArMTAyLjDCsEMp
CkNvcmUgMTogICAgICAgICArMzIuMMKwQyAgKGhpZ2ggPSArODIuMMKwQywgY3JpdCA9ICsx
MDIuMMKwQykKCm5jdDY3NzYtaXNhLTAyOTAKQWRhcHRlcjogSVNBIGFkYXB0ZXIKVmNvcmU6
ICAgICAgICAgKzAuODggViAgKG1pbiA9ICArMC4wMCBWLCBtYXggPSAgKzEuNzQgVikKaW4x
OiAgICAgICAgICAgKzEuMDQgViAgKG1pbiA9ICArMC4wMCBWLCBtYXggPSAgKzAuMDAgVikg
IEFMQVJNCkFWQ0M6ICAgICAgICAgICszLjM5IFYgIChtaW4gPSAgKzIuOTggViwgbWF4ID0g
ICszLjYzIFYpCiszLjNWOiAgICAgICAgICszLjM4IFYgIChtaW4gPSAgKzIuOTggViwgbWF4
ID0gICszLjYzIFYpCmluNDogICAgICAgICAgICsxLjAxIFYgIChtaW4gPSAgKzAuMDAgViwg
bWF4ID0gICswLjAwIFYpICBBTEFSTQppbjU6ICAgICAgICAgICArMi4wNCBWICAobWluID0g
ICswLjAwIFYsIG1heCA9ICArMC4wMCBWKSAgQUxBUk0KM1ZTQjogICAgICAgICAgKzMuMzkg
ViAgKG1pbiA9ICArMi45OCBWLCBtYXggPSAgKzMuNjMgVikKVmJhdDogICAgICAgICAgKzMu
MjYgViAgKG1pbiA9ICArMi43MCBWLCBtYXggPSAgKzMuMzAgVikKZmFuMTogICAgICAgICAg
ICAwIFJQTSAgKG1pbiA9ICAgIDAgUlBNKSAgQUxBUk0KZmFuMjogICAgICAgICAgMjc1IFJQ
TSAgKG1pbiA9ICAgIDAgUlBNKSAgQUxBUk0KZmFuMzogICAgICAgICAgICAwIFJQTSAgKG1p
biA9ICAgIDAgUlBNKSAgQUxBUk0KZmFuNDogICAgICAgICAgICAwIFJQTSAgKG1pbiA9ICAg
IDAgUlBNKSAgQUxBUk0KZmFuNTogICAgICAgICAgICAwIFJQTSAgKG1pbiA9ICAgIDAgUlBN
KSAgQUxBUk0KU1lTVElOOiAgICAgICAgKzI2LjDCsEMgIChoaWdoID0gICswLjDCsEMsIGh5
c3QgPSAgKzAuMMKwQykgIEFMQVJNICBzZW5zb3IgPSB0aGVybWlzdG9yCkNQVVRJTjogICAg
ICAgICs4NC41wrBDICAoaGlnaCA9ICs4MS4wwrBDLCBoeXN0ID0gKzc2LjDCsEMpICBBTEFS
TSAgc2Vuc29yID0gdGhlcm1pc3RvcgpBVVhUSU46ICAgICAgICArNzQuNcKwQyAgKGhpZ2gg
PSArODAuMMKwQywgaHlzdCA9ICs3NS4wwrBDKSAgc2Vuc29yID0gdGhlcm1pc3RvcgpQRUNJ
IEFnZW50IDA6ICArMzMuNcKwQyAgCmNwdTBfdmlkOiAgICAgKzIuMDUwIFYKCg==
--------------010009090503040508070508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010009090503040508070508--
