From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Feb 2008 18:18:49 +0000
Subject: Re: [lm-sensors] D201GLY2, Winbond W83627DHG-B No-Output
Message-Id: <20080210191849.56c07d9c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47ADB7EE.3040403@plzk.de>
In-Reply-To: <47ADB7EE.3040403@plzk.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Stefan,

On Sat, 09 Feb 2008 15:25:50 +0100, Stefan Bauer wrote:
> The output of sensors is:
> 
> bucht:/home/sb/linux-2.6.24# sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> 
> coretemp-isa-0000
> Adapter: ISA adapter

You want to upgrade lm-sensors. w83627dhg and coretemp are supported
since 2.10.2. You seem to be still using 2.10.1.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
