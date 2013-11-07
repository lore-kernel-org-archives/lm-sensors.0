From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 07 Nov 2013 23:35:26 +0000
Subject: Re: [lm-sensors] About the Asus F2A85 temperature sensor (it8603e)
Message-Id: <527C23BE.9030308@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>

> P.S. I have reason to believe that the it87 device we are talking about is
> actually an emulation running on an 8051 co-processor, specifically the EC
> (Embedded Controller) in the AMD A85 Hudson chipset. The it87 emulation is
> poorly written in the 8051 code and can result in unexpected effects -- bugs.
> I have specifically seen the sensor stop updating (as if it just stopped
> sampling values).

No, the chip is real, just look to the corner near audio connectors ;) The chip 
is derivate of IT8728 it seems. It has lower pin count and lower number of 
features. There are just two input temperatures and 3 fan inputs/pwms. Voltages 
are all there. It looks like the voltages have fixed functions for inputs 
because they are also used in the voltage under/over voltage protections.

I'm tempted to treat this chip as IT8728F. Does anyone have a datasheet of IT8728F?

Thanks
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
