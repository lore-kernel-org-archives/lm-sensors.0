From: "Jan van Tiggelen" <den_tichel@zonnet.nl>
Date: Tue, 17 Apr 2007 21:27:51 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <001401c78137$411ea420$6a01a8c0@COBALTPC>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David / Jordan, hi,-

> To: Jean Delvare
> CC: Jordan; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] w83627dhg msi 975x problems
> 
> If these modes were in use, pwmN_enable would be 3 or more if I
> remember correctly. David knows the code better and should be able to
> confirm that. So it really looks like it's not what your system uses.
> 
> Correct. pwmN_enable = 2 would mean SmartFan I mode, but 2 or higher
> would mean automatic control by the w83627dhg chip. However, using
> PECI, the fan control could be done in ACPI (yuck) or possibly in the
> ICH7.
> 

At the moment, schematics for both the 83627DHG and the ICH7 and also the
full bios changelog for this board are in the request queue at MSI again.

Probably this time it does make sense to use the PECI interface for giving
more system controls to the ICH7. Let's see what the schematics will tell
us.

Jordan, meanwhile, could you post your current BIOS version? And did you
check the other outputs from your sensors, such as voltages, etc.... Are
they all reading correctly?

Kind regards,

Jan van Tiggelen


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
