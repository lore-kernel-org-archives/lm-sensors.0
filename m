From: Werner Goebl <werner.goebl@mail.mcgill.ca>
Date: Wed, 19 Dec 2007 19:21:24 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <47696F34.4080505@mail.mcgill.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

>> good point -- I relied on informations from the web about
>> the Q965 chipset, but I learned that I was wrong!
>>
>> So: I have a SMSC SCH5514D-NS chip (which is not on the list
>> unfortunately). I guess I am stuck now?
> 
> Good information, thanks. At least we can update sensors-detect to
> correctly identify your chip. Unfortunately, this being a Dell
> machine, SMSC won't provide technical information for this chip to me
> since I'm an HP person :-)

Ah, I didn't think of such things. I saw on the SMSC webpage 
that there is information only to a very limited number of 
chips.

> Let's try to figure out if it's compatible to any other supported SMSC
> chip before we give up. Can you run 'isadump -k 0x55 0x2e 0x2f 0xa'
> and post the output?

eh voila:
 > sudo isadump -k 0x55 0x2e 0x2f 0xa
WARNING! Running this program can cause system crashes, data 
loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 10 using bank register 0x07.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 83 0f 38 00 04 00 2e 00 00 00 00 00 10 00 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

All the best
Werner

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
