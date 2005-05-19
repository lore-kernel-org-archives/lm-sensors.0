From: pgaige@cadesis.com (=?ISO-8859-1?Q?Gaig=E9_Pierre?=)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: support for p4s8x motherboard
Message-Id: <3EFC9188.6030908@cadesis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFA15C6.5020503@cadesis.com>
In-Reply-To: <3EFA15C6.5020503@cadesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>Ok, After a good nigth and a reboot of my machine, the sensors-detect 
>>behave completly different.
>>I've included the results below.
>>But now the problem comes when I try to load the w83781d module as it
>>is suggested, my motherboard plays continously some beep beep that I
>>have never heard before ;-)
> 
> 
> Maybe some value is (supposedly) out of limits and you have beeping
> enabled. Does "sensors -s" (as root) end the noise? What does "sensors"
> output then? Does unloading the w83781d module stop the beeps?
> 

"sensors -s" does not end the noise and gives no information.
Unloading the module does not help too.
Only a reboot stop the beep sequence.
