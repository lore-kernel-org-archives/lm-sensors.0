From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: fscpos driver
Message-Id: <20050105203901.108e1bf4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For bit vector registers, masking might be fine. What is not OK
> however is to mask a *range* with 0xff instead of simply checking that
> the value is between 0 and 255 and return -EINVAL or similar if it
> isn't. It's usually better to return an error to user-space than
> silently drop an invalid value. Do the best you can.

On second thought, for ranges, you might simply force the input value
into the range instead of returning an error. This is what other drivers
do.

-- 
Jean Delvare
http://khali.linux-fr.org/
