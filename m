From: Luca <kronos.it@gmail.com>
Date: Mon, 21 May 2007 21:53:49 +0000
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Message-Id: <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070513223329.GA29207@dreamland.darkstar.lan>
	 <46520F36.4080006@assembler.cz>
In-Reply-To: <46520F36.4080006@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 5/21/07, Rudolf Marek <r.marek@assembler.cz> wrote:
> ATK0110 ATK0110:00: atk_enumerate_fan: invalid fan count 3 (should be 5)
> ATK0110: probe of ATK0110:00 failed with error -22

Ok, the FAN package contains 5 items, but the enumerator only
advertises the first 3. I guess that the other 2 (chipset fan and
chassis2 fan) are not usable? Are the connectors for those two fans on
your motherboard? Do you get any reading from them?

Plus: your ACPI code uses the full "magic number" (first item in the
package) to demux the reading, while my board masks the upper 2 bytes;
I need to change the driver. Will send another iteration.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
