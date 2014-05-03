From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 03 May 2014 20:32:49 +0000
Subject: Re: [lm-sensors] New field in MSR_TEMPERATURE_TARGET
Message-Id: <53655271.7080505@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140501120744.1cddd118@endymion.delvare>
In-Reply-To: <20140501120744.1cddd118@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Khali,

After some google magic I found this:

http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-=
gen-core-family-mobile-u-y-processor-lines-vol-1-datasheet.pdf

TCC Activation Offset can be used to activate the Adaptive Thermal Monitor =
at
temperatures lower than TjMAX. It is the preferred thermal protection mecha=
nism=20
for Intel Turbo Boost Technology 2.0 operation since ACPI passive throttlin=
g=20
states will pull the processor out of turbo mode operation when triggered. =
An=20
offset (in degrees Celsius) can be written to the TEMPERATURE_TARGET (0x1A2=
)=20
MSR, bits [29:24]. This value will be subtracted from the value found in bi=
ts=20
[23:16]. The default offset is 0 =B0C, where throttling will occur at TjMAX=
. The=20
offset should be set lower than any other protection such as ACPI _PSV trip=
 points.

So yes you could make it writable by user, and this value is always subtrac=
ted.=20
It looks like this should be taken into account for tempN_crit on the Silve=
rmont=20
CPUs.

The Silvermont CPU can be identified in your [1] by looking at 35.4:

Table 35-6 lists model-specific registers (MSRs) for Intel processors based=
 on=20
the Silvermont microarchitecture These processors have a CPUID signature wi=
th=20
DisplayFamily_DisplayModel of  06_37H, 06_4AH, 06_4DH,
06_5AH, and 06_5DH, see Table 35-1.

Thanks
Rudolf



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
