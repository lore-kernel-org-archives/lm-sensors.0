From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Fri, 16 May 2008 22:18:18 +0000
Subject: Re: [lm-sensors] abituguru probe failure
Message-Id: <200805162318.18097.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805162307.28224.alistair@devzero.co.uk>
In-Reply-To: <200805162307.28224.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 16 May 2008 23:07:28 Alistair John Strachan wrote:
> Hi,
>
> I have an IP35 Pro mainboard with the uGuru feature. Until recently I was
> using the abituguru hwmon driver without issue. Recently (possibly since
> upgrading the BIOS to 16) the driver no longer loads, citing:
>
> abituguru3: no Abit uGuru3 found, data = 0x00, cmd = 0x55

^^^^
Obviously the report should have been wrt the abituguru_3_ driver.

Sorry about that, I didn't even notice the other driver.

-- 
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
