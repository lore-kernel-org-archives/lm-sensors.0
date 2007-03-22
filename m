From: den_tichel@zonnet.nl (Jan van Tiggelen)
Date: Thu, 22 Mar 2007 20:47:19 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf
Message-Id: <20070322204721.B00CC34DB@mta-fe.casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
In-Reply-To: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Curt, hi,-

Assuming that you've figured out a correct setting for your FAN divisors,
last thing left to do is setting right labels and Vin calculation for the
other channels.

So, based on your feedback of voltage levels, and with the schematics of the
MSI K9N4 SLI-F and the pre-set definitions of the W83627EHF calculations I
could suggest for sensors.conf:

chip "w83627dhg-*"

labels:
label in0 "VCore"
label in1 "+12V"
label in2 "5V"
label in3 "-12V"
label in5 "AVCC"
label in7 "VSB"
label in8 "VBAT"

computations:
compute in1 @*(1+(56/10)), @/(1+(56/10))
compute in2 @*(1+(22/10)), @/(1+(22/10))
compute in3 -@*(1+(56/10)), -@/(1+(56/10))

Let me know if this gives you the correct readings. If it's not, I'll try
and get the values for Rin and Rf.

And for the FAN labels:
Label fan3 "Northbridge Fan"


Honestly speaking: for the voltage computations I lost track a bit, since
627EH is derived from 781D in turn...
Maybe you could post a better update, with the mainboard on hand?

Kind regards,

Jan van Tiggelen


