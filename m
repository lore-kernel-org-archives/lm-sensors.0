From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: ref 1501
Message-Id: <4037A28C.3010501@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <19808.1073178613@www49.gmx.net>
In-Reply-To: <19808.1073178613@www49.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't see any problem with 1535.
Looks like the as99127f is not getting detected by the w83781d driver.
I suggest using i2cdetect and try forcing the w83781d driver
to see what is going on.

Jean Delvare wrote:
> Mark, Dan,
> 
> Can you please take a look?
> http://archives.andrew.net.au/lm-sensors/msg06567.html
> 
> Looks like a problem with the i2c-ali1535 driver, but I don't know
> enough to help.
> 
> Thanks.
> 
