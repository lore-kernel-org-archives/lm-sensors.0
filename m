From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 01 May 2006 11:15:07 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <4455EDBB.4000905@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thomas Andrews wrote:
> On Thu, Apr 27, 2006 at 11:41:14PM +0200, Jean Delvare wrote:
>
>   
>> Can you please comment on this?
>> http://bugzilla.kernel.org/show_bug.cgi?idd45#c15
>>
>> This is a propsal to make the scx200_acb driver's default base
>> addresses configurable through Kconfig. What do you think?
>>
>> Another possibility would be to detect them at runtime depending on
>> some platform data. Sounds more complex, if possible at all.
>>
>> Or we can stick to the current state (default addresses, can be
>> overriden with module parameters).
>>
>> What makes the current default addresses (0x820 and 0x840) more
>> legitimate than what Alexander has (0x810 and 0x820)?
>>     
>
> I've been wondering about this myself. I also use the wrap boards, and
> I've found that the address can be automatically set using something
> like this:
>
> static void detect_acb_base_addresses(int *acb1, int* acb2)
> {
>     unsigned char h1 = 0;
>     unsigned char l1 = 0;
>     unsigned char h2 = 0;
>     unsigned char l2 = 0;
>
>     /* Select ACB1  (LDN 5) */
>     outb(0x07,CFG_INDEX);
>     outb(0x05,CFG_DATA);
>     outb(0x60,CFG_INDEX);
>     h1 = inb(CFG_DATA);
>     outb(0x61,CFG_INDEX);
>     l1 = inb(CFG_DATA);
>
>     /* ACB2 (LDN 6) */
>     outb(0x07,CFG_INDEX);
>     outb(0x06,CFG_DATA);
>     outb(0x60,CFG_INDEX);
>     h2 = inb(CFG_DATA);
>     outb(0x61,CFG_INDEX);
>     l2 = inb(CFG_DATA);
>     *acb1 = (h1 << 8) | l1;
>     *acb2 = (h2 << 8) | l2;    
>     DEBUG(1,printk("ACB1 at %x, ACB2 at %x",*acb1,*acb2));
> }
>
> Would this not work for the whole family ?
>
> Regards,
> Thomas
>   

I have a soekris net4801 which has the same sc-1100.
On my board, ISA addys 2e, 2f talk to a separate Super-IO chip, pc87360.
which IIRC has an acb unit also.
Back when I got the board, the presence of 2 superio devices was somewhat
confusing, until Id read both datasheets - 2x.

FWIW, the pc87360 has these (from a pre-proto-patch I still have)

+char* funcblocks[] = {
+       "Floppy Disk Controller (FDC)",
+       "Parallel Port (PP)",
+       "Serial Port 2 with IR (SP2)",
+       "Serial Port 1 (SP1)",
+       "System Wake-Up Control (SWC)",
+       "Keyboard and Mouse Controller (KBC) - Mouse interface",
+       "Keyboard and Mouse Controller (KBC) - Keyboard interface",
+       "General-Purpose I/O (GPIO) Ports",
+       "ACCESS.bus Interface (ACB)",
+       "Fan Speed Control and Monitor (FSCM)",
+       "WATCHDOG Timer (WDT)",
+       "Game Port (GMP)",
+       "Musical Instrument Digital Interface (MIDI) Port",
+       "Voltage Level Monitor (VLM)",
+       "Temperature Sensor (TMS)",
+       NULL
+};
+
+
+struct pc87366_unit pc87366_units[] = {
+       { 8,    "Floppy Disk Controller (FDC)" },
+       { 0x10, "Parallel Port (PP)" },
+       { 8, "Serial Port 2 with IR (SP2)" },
+       { 8, "Serial Port 1 (SP1)" },
+       { 0x10, "System Wake-Up Control (SWC)" },
+       { 0x10, "Keyboard and Mouse Controller (KBC) - Mouse interface" },
+       { 0x10, "Keyboard and Mouse Controller (KBC) - Keyboard 
interface" },
+       { 0x0c, "General-Purpose I/O (GPIO) Ports" },
+       { 6,    "ACCESS.bus Interface (ACB)" },
+       { 0,    "Fan Speed Control and Monitor (FSCM)" },
+       { 4,    "WATCHDOG Timer (WDT)" },
+       { 0x0d, "Game Port (GMP)" },
+       { 3,    "Musical Instrument Digital Interface (MIDI) Port" },
+       { 0x10, "Voltage Level Monitor (VLM)" },
+       { 0x0f, "Temperature Sensor (TMS)" },
+       { 0,    NULL }
+};


the sc-1100 has fewer functional units; I dimly recall poking at them 
this same way,
but I cant dig up any old bones.

