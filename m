From: reuben-lmsensors@reub.net (Reuben Farrelly)
Date: Sat, 26 Nov 2005 10:57:44 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <4388318A.60607@reub.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

On 11/26/2005 10:52 PM, Jean Delvare wrote:
> Hi Reuben,
> 
>> The board I have is an Intel D945PVSLKR, and it has two relevant i2c chips on 
>> it.  There is an SMC LPC47M182 chip, but also an Analogue Devices ADT7476ARQZ 
>> onboard near the CPU.  I suspect that the Analogue Devices chip is the more 
>> useful chip of the two (see ticket comment by Khali).
> 
> It's "SMSC", and "Analog Devices". The LPC47M182 is not an "i2c chip".

Oops <embarassed look>

>> I have posted the rather lengthy output of sensors-detect up on my website at 
>> http://www.reub.net/files/kernel/
>>
>> There's a data sheet about this chip here:
>>
>> http://www.analog.com/en/prod/0%2C2877%2CADT7476%2C00.html
>>
>> If this chip is in fact unsupported, what can I do to help with getting it 
>> supported and functional?
> 
> Please provide a dump of the Analog Devices chip:
> i2cdump 0 0x2e b

[root@typhoon ~]# i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 77 6c c3 c5 be 36 29 27 62 0c 57 0d 46 36 ff ff    wl???6)'b?W?F6..
30: 33 4c 4c 00 00 00 00 00 ff ff ff 00 00 76 41 69    3LL..........vAi
40: 05 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 22 7a    ????........?""z
60: 8a 80 e8 88 33 4c 4c 38 2d 2d 45 41 41 24 40 00    ????3LL8--EAA$@.
70: 00 00 00 00 00 00 1a 23 f0 00 00 55 01 00 00 00    ......?#?..U?...
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@typhoon ~]#


Reuben

