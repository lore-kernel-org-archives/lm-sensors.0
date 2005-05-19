From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <42177204.5070400@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050218154856.GA14189@home.fluff.org>
In-Reply-To: <20050218154856.GA14189@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben, hi Mark,
> 
> 
>>>isn't this chip compatible with the LM75 and its driver?
>>>what's different about it if anything?
>>
>>configuration register is different, the temperature
>>comparison is also different (tmp101 has low/high range)
> 
> 
> Configuration is extended but compatible. Your driver doesn't seem to
> make use of the extra configuration bits (only raises OS/ALERT, which is
> already set by default).

I'm going to fix the lm75 driver to only rewrite the CMP/INT bit,
and only if it's set to INT, OK?
This will be kinder to compatible chips.
