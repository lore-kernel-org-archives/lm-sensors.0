From: <kpyle@austin.rr.com>
Date: Tue, 13 Oct 2009 22:13:14 +0000
Subject: Re: [lm-sensors] sensors.conf for im-645gse-a (msi9830)
Message-Id: <20091013221314.5V077.602614.root@hrndva-web01-z01>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4BA746.7050803@gmx.de>
In-Reply-To: <4A4BA746.7050803@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/03/2009 12:29 PM, Hans de Goede wrote:
> On 07/01/2009 08:13 PM, Thomas Ettwein wrote:
> > # lm_sensors configuration file for the MSI IM-945GSE-A motherboard
> > # Atom N270, Dual Gigabit Intel 82574L controllers, VGA, DVI
> > # 2009-07-01 Thomas Ettwein
>
>
> Thanks, it has been added to the wiki:
> http://lm-sensors.org/wiki/Configurations/MSI/IM-945GSE-A

I used the wiki configuration for a MSI IM-945GSE-A.  The sensors command reports that 12V is at 14.7V while a simultaneous measurement at the ATX connector with a volt meter shows 12.3V.  I don't know enough about the board to measure at the SuperIO chip used by lm_sensors on this board, but I'm assuming the sensor report is incorrect.  Could the values used to compute in5 in the wiki configuration be incorrect?  All other values reported by the sensors command seem reasonable.

Thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
