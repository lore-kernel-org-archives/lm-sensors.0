From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 Apr 2008 15:41:42 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 3/5] lm75: support 12-bit
Message-Id: <20080422174142.68a28c36@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161030.56626.david-b@pacbell.net>
In-Reply-To: <200804161030.56626.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 20 Apr 2008 18:03:28 +0200, Jean Delvare wrote:
> This conversion function should return the following depending on the
> resolution:
> 
>  9-bit: ((temp +/- 250) / 500) << 7
> 10-bit: ((temp +/- 125) / 250) << 6
> 11-bit: ((temp +/- 62) / 125) << 5
> 12-bit: ((temp +/- 31) / 62) << 4

Oops, this last one is of course not correct. This should read, for
example:

12-bit: ((temp * 2 +/- 62) / 125) << 4

So we might as well write the above:

 9-bit: (( temp       +/- 250) / 500) << 7
10-bit: (((temp << 1) +/- 250) / 500) << 6
11-bit: (((temp << 2) +/- 250) / 500) << 5
12-bit: (((temp << 3) +/- 250) / 500) << 4

which is easier to generalize.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
