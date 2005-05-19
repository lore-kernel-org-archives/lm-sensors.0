From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Additional info for ticket #1148
Message-Id: <3EE7BFB4.5050301@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1054890869.11041.3.camel@nazgul>
In-Reply-To: <1054890869.11041.3.camel@nazgul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The address of the first chip to be recognized (the 627HF in your case)
should be the 2nd argument to force_subclients.
It probably isn't; fix it and it should work.

OverrideX wrote:
> Ok, while looking for a solution to my problem I found that ticket #1148
> matched it, I have a S2466N-4M (the difference between this board and
> the S2466 is that it has a 4MB rom rather than 2MB) the modprobe w83781d
> force_subclients=0,0x2c,0x4a,0x4b trick from ticket #941 isn't working
> on this, dmesg outputs:
> 
> i2c-proc.o version 2.6.1 (20010825)
> w83781d.o version 2.6.5 (20020915)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83627HF chip] registered to adapter [SMBus AMD768
> adapter at 80e0](pos. 0).
> i2c-core.o: client [W83627HF subclient] registered to adapter [SMBus
> AMD768 adapter at 80e0](pos. 1).
> i2c-core.o: client [W83627HF subclient] registered to adapter [SMBus
> AMD768 adapter at 80e0](pos. 2).
> i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD768
> adapter at 80e0](pos. 3).
> w83781d.o: Subclient 0 registration at address 0x49 failed.
> i2c-core.o: client [W83782D chip] unregistered.
> 
> This is kernel 2.4.20, could it be the oldish i2c version?  Thanks for
> any info -Dan
> 
> --
> OverrideX <overridex@punkass.com>
> GPG Key Fingerprint = 4AD5 CE9C D7C8 0069 BDD3 7F72 3AB2 642A 5A5D EB89
> 
> Perilous to all of us are the devices of an art deeper than we ourselves
> possess. -- Gandalf the Grey [J.R.R. Tolkien, "Lord of the Rings"]
> 
> 
