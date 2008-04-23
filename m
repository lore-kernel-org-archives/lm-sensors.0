From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Apr 2008 15:59:26 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <20080423175926.0786ddfb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Apr 2008 17:50:47 +0200, Gabriel C wrote:
> Jean Delvare wrote:
> > Maybe we could write an ACPI driver for your motherboard... I see the
> > ATK0110 ID,
> 
> I think all newer ASUS motherboards got that ATK0110 ID.
> 
> > I seem to remember someone had written an experimental
> > driver for it. Rudolf should know more.
> 
> Do you mean this one ?
> 
> http://lkml.org/lkml/2007/5/13/209

I think so, yes, but I have no idea if there is a more up-to-date
version of this driver or not.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
