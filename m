From: stuart@sswindells.free-online.co.uk (Stuart Swindells)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <200408131924.i7DJOCKW029323@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
In-Reply-To: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Before
Value		value_min	value_max
in0		5		3845
in1		2853		3477
in2		3141		3477
in3		2853		3157
in4		5		5
in7		2837		3125
in8		2405		3605
temp1_type	3435
temp2_type	3435
temp3_type	3435

After:
Value		value_min	value_max
in0		2661		2949
in1		2853		3477
in2		3141		3477
in3		2853		3157
in4		805		341
in7		2837		3125
in8		2405		3605
temp1_type	3435
temp2_type	3435
temp3_type	3435
-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 13 August 2004 19:29
To: Stuart Swindells
Cc: sensors@Stimpy.netroedge.com
Subject: Re: Ticket 1751

> (...)
> Is the output with the fault, it's not possible to get output without
> the fault, since as soon as lm_sensors is installed, the fault
> appears.

Aha, yes, of course. Stupid me.

Let's try a different approach then. Please compare (and post) values of
files:
  in*_min
  in*_max
  temp*_type
before and after the installation of the lm_sensors package.

I suspect that writing the voltage limits changes the thermal sensor
type as a side effect, but I could be wrong.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

-- 
This email has been verified as Virus free
Virus Protection and more available at http://www.plus.net

