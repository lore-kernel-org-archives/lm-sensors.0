From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: help
Message-Id: <Pine.OSF.4.50.0212010917340.5399-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020728124708.244675c6.nec@chello.hu>
In-Reply-To: <20020728124708.244675c6.nec@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 30 Nov 2002, Stealth wrote:

> [root@Nooblesse root]# sensors-detect
>  This program will help you to determine which I2C/SMBus modules you need to
>  load to use lm_sensors most effectively.
...
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Success!
>     (confidence 8, driver `Unwritten (W83697HF)')

You did not tell release of lm_sensors you are running.
This chip is unsupported until 2.6.3.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
