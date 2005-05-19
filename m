From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC adding special interfaces to sysfs?
Message-Id: <42376271.7000005@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
In-Reply-To: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:
> Greetings,
> 
> Still learning lm_sensors interface, am porting adm9240 to 2.6.
> 
> This chip has an analog output which is rare these days, plus 
> an output to send a reset pulse (open drain I/O) to an external 
> latch for Chassis Intrusion (CI).  Wrinkle with CI clear function 
> is there are two register/bit locations for doing the deed.
> 
> I really would welcome ideas on how to incorporate these to the 
> sysfs interface, offering this patch as a starting point.  I may 
> have missed a miscellaneous control interface somewhere?  In that 
> case pointers to docs appreciated.
> 
> Cheers,
> Grant.
> 
> 
> --- linux-2.6.11-mm2-p2x/Documentation/i2c/sysfs-interface.orig	2004-12-25 08:34:01.000000000 +1100
> +++ linux-2.6.11-mm2-p2x/Documentation/i2c/sysfs-interface	2005-03-12 12:48:10.000000000 +1100
> @@ -272,3 +272,12 @@
>  
>  eeprom		Raw EEPROM data in binary form.
>  		Read only.
> +
> +analog_out	mV analog output voltage
> +		Read/Write.
> +
> +clear_ci[1-2]	Tell chip to output a pulse to reset external Chassis 
> +		Intrusion latch, there are two methods for doing this 
> +		using a different register.bit
> +		Write Only.
> +
> 

adm1026 uses analog_out so that's fine.

no other driver bothers with clearing chassis intrusion, so I wouldn't bother.
If you're motivated, though, do it however  you want. If it were me,
I'd name it chassis_clear and implement both methods whenever it's written to.

mds
