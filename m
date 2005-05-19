From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050209215052.1fbed69b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I'm sorry, I didn't know I was dumping all this on a mailing list.
> 
> If you would rather work with me one-on-one for this, let me know.

No, CCing the list is alright, so that people can follow the advancement
of our investigation, and also because the list is archived so later
people will be able to know all the details they may need, even if I am
no more here. And also because people can see things I miss, and tell me
:)

That said, you just have to post to the list once. Having it both as To:
and CC: like you just did is probably too much ;)

Back to our business:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> (...)
> 50: ff ff 00 ff ff ff 00 80 88 20 ff ff 19 a4 ff 05

ID register is 0x58, value is 0x88. The datasheet advertises 0xA1. I
start wondering if there is anything true in this datasheet ;)

Anyway, I updated the sensors-detect script with 0x88:
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect

It should now find the chip at ISA address 0x290, hopefully.

Thanks,
-- 
Jean Delvare
