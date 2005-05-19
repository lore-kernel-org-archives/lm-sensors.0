From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <20040626085629.11bb99ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> A clarification:
> 
> The w83l785ts error handling is in the 2.6 kernel version only.
> 
> The adm1021 driver has error handling in the 2.4 kernel version only.

Thanks for the clarification. I thought I had ported the w83l785ts error
handling back to 2.4 but actually you're right, I didn't. And I didn't
remember that the adm1021 had partial error handling as well, in 2.4.

I may backport the w83l785ts error handling later today if I find some
time to do so.

-- 
Jean Delvare
http://khali.linux-fr.org/
