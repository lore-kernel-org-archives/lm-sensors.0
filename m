From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <1076926458.403097fa4c6aa@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

Quoting "Sven E." <dark@verfeiert.org>:

> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
>  
> Driver `w83627hf' (may not be inserted):
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627THF Super IO Sensors' (confidence: 8)

We usually trust Super IO more than ISA. In newer versions of
sensors-detect, Super IO have a confidence of 9, so it would have
suggested w83627hf over it87 in your case.

> As one can see now the Winbond is recommended as expected. yet, if I
> use the recommended modules:
> 
> sensors
> w83627thf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> ERROR: Can't get alarm data!
> ERROR: Can't get beep data!
> ERROR: Can't get IN0 data!
> ERROR: Can't get IN2 data!
> ERROR: Can't get IN3 data!
> ERROR: Can't get IN4 data!
> ERROR: Can't get IN7 data!
> ERROR: Can't get IN8 data!
> ERROR: Can't get FAN1 data!
> ERROR: Can't get FAN2 data!
> ERROR: Can't get TEMP1 data!
> ERROR: Can't get TEMP2 data!
> 
> Khali supposed the lib might be outdated, but where can I find the
> lib.

ls -l /usr/lib/libsensors*
ls -l /usr/local/lib/libsensors*

You can also do "$(which sensors)" and "ldd $(which sensors)" to see
which library the sensors binary is linking to. If the library prefix
differs from sensors one, there's something bad.

> I am using gentoo, I patched the kernel since I need bttv I
> installed all needed packages etc.

We have a long history of problems with Gentoo. They have kernel patches
that often make lm_sensors fail, although "sensors" alone usually works
(this is "sensors -s" that usually fails).

I'm not sure I understand what you mean with "I patched the kernel". Did
you patch Gentoo kernel sources, or a vanilla kernel?

> gentoo says I use lm-sensors 2.8.1 as well as i2c 2.8.1

I would recommend that you clearly choose your side, and stick to it.
Either use a Gentoo kernel and stick to their version of i2c and
lm_sensors, or compile a vanilla kernel with my i2c patch, and install
lm_sensors on your own (same version as i2c, preferably). Mixing Gentoo
stuff with our own is likely to cause more trouble than it's worth.

-- 
Jean Delvare

