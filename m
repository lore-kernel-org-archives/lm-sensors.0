From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Tue, 10 Jan 2006 21:33:18 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43C4281E.506@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean / list,

Jean Delvare wrote:
> Which version of lm_sensors (user-space) are you using? The W83687THF
> detection was added in version 2.9.2, so you need at least this
> version. 
>   
My  problem was that 2.9.1 user-space tools were still in 
/usr/[bin;sbin] and these were being utilized instead of the >2.9.2 
versions located /usr/local/[bin;sbin].  After I got that straightened 
out, sensors-detect did indeed find the chip.

As an aside, the 2.9.2 version generated several errors during "make 
user" (sorry, can't recall what was stated, and a quick google search 
didn't illuminate for me what may have been generating the problem(s)).  
However, I grabbed the CVS version (which provides sensors-detect 
revision 1.405 (2005/12/09 19:44:49) ) and it worked without problem.   
[Let me know if you're interested in what the errors were for my "make 
user" attempt with the 2.9.2 d/l and I will revisit that issue].

> You could provide the output of "isadump -k 0x87,0x87 0x2e 0x2f 0x0b"
> so that I compare the ID of your chip with what is believed to the the
> W83687THF chip ID. Note that you need isadump from lm_sensors 2.9.2 for
> it to work.
>   

isadump -k 0x87,0x87 0x2e 0x2f 0x0b
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 11 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 85 42 ff 00 44 00 00 ff 50 03 f0 02 00 00 00 00
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 02 90 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 11 3f ff ff ff ff ff ff ff ff ff ff ff ff ff ff

In case an"isadump 0x295 0x296" is also of assistance, it yields:
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 70 01 5f 17 2d 3c 11 70 5f 01 01 3c 3c 01 01
10: 01 00 31 00 00 01 01 3c 43 00 ff ff 24 32 00 c9
20: 54 5f ce bb a2 9d 10 27 7f 7b ff f0 00 84 9b 48
30: b3 d2 00 02 da 60 ad 07 6a 02 d5 12 a6 60 00 00
40: 01 d6 09 de ff 00 00 f0 2d 02 01 44 10 15 01 a3
50: 27 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff
60: 54 5f ce bb a2 9d 10 27 7f 7b ff f0 00 84 9b 48
70: b3 d2 00 02 da 60 ad 07 6a 02 d5 12 a6 60 00 00
80: 01 70 01 5f 17 2d 3c 11 70 5f 01 01 3c 3c 01 01
90: 01 00 31 00 00 01 01 3c 43 00 ff ff 24 32 00 cb
a0: 54 5f ce bb a2 9d 10 27 7f 7b ff f0 00 84 9b 48
b0: b3 d2 00 02 da 60 ad 07 6a 02 d5 12 a6 60 00 00
c0: 01 00 00 de ff 00 00 f0 2d 02 01 44 10 15 01 a3
d0: 27 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff
e0: 54 5f ce bb a2 9d 10 27 7f 7b ff f0 00 84 9b 48
f0: b3 d2 00 02 da 60 ad 07 6a 02 d5 12 a6 60 00 00

> I just updated the patch for Linux 2.6.15:
> http://jdelvare.net2.nerim.net/sensors/linux-2.6.15-hwmon-w83687thf.diff
>
> But this shouldn't be fundamentally different from what you had
> starting from the 2.6.13-rc3 patch, if you fixed it properly.
>   

Yes.  Doesn't appear to have been any problems there.  It was using the 
v2.9.1 user tools that tripped me up.


> Please also keep in mind that for user-space support you need to apply
> the following patch to the lm_sensors sources:
>   http://jdelvare.net2.nerim.net/sensors/CVS-w83687thf.diff
> I checked it and it still applies to CVS with some offset.
>   

It Applied without issue, but your wording ("it still applies with some 
offset") makes me think I may have missed something or done something 
wrong here.  And indeed, although sensors-detect now detects the IC, I 
haven't succeeded with getting the support implemented yet.  I will 
re-look at this later tonight, time permitting.


> Nothing to worry about. Sure we don't support this chip right now, but
> given the good relationship that exists between the lm_sensors group
> and Winbond, I am certain we should be able to come up with a solution
> fast.

And I would like to thank Yuan who, once made aware of this issue, 
expedited the delivery of the data sheet.  Much obliged for your help. :)

Thanks, Steven







