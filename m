From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 25 Nov 2006 10:04:40 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <45681538.6010401@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please CC to the list.

Paul Reilly wrote:
> Hi Rudolf,
> 
> Thanks for your help. The temp readings came back for a while,
> but are now gone again. Interesting they do change, from -199.5
> to -197.5 etc. So it seems to be affected by possible the real
> reading from the CPU.

Or corrupted.

> 
>> cat /proc/acpi/dsdt > /tmp/dsdt.bin
> 
> http://astropaul.com/export/dsdt.bin

Ok I did not found anything suspect here.


> I cannot make too many changes to this machine. It runs a static
> kernel ( LM85 module is also compiled statically). As suggested I
> have turned off ACPI thermal zone, and turned on i2c bus debugging.
> It will be rebooted tomorrow, and I will report back

Good thanks.

> Will K8 Temp work with Opteron chip?

It will but this cool feature is undocumented by AMD for some reason. (for the 
pre F. rev of cores)

regards
Rudolf

