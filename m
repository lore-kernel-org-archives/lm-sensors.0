From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: hi about lm_sensors issue
Message-Id: <20050318222350.7588b2f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b050315215248daf6e5@mail.gmail.com>
In-Reply-To: <ea9ff50b050315215248daf6e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Filip,

> 10x another thing I found is that I need CPU temp offset +14 and
> nForce +9 how to set that?

Something like:

    compute temp1 @+9, @-9
    compute temp2 @+14, @-14

That being said, how do you know you need these offsets? Direct
comparisons of BIOS values and sensors values are usually not a good
idea:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e12

-- 
Jean Delvare
