From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 06 Nov 2005 11:14:25 +0000
Subject: [lm-sensors] Re: ATI SMBus - here is more info
Message-Id: <436DD75A.5080205@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Patrick wrote:
> Rudolf,
> 
> Googling around I found your posting at
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013946.html
> I have an Acer Ferrari with the ATI Xpress 200 chipset and am interested
> in a module for the ATI SMBus so I can see temps and fan speed with
> gkrellm. In your posting I read the info you require so have attached
> it. If you need anything else please let me know.
> 
> Thanks for your great work. Much appreciated!
> 

Hello, thanks.

I read the DSDT table so far I could see temperatures and fan speed on this notebook are handled by Emmbedded controller,
Perhaps it could be possible  to develop some ACPI module like ibm-acpi for the ACER extras. It seems it has no ordinary chip
for HW monitoring.

(this should not be so difficult)

                   Name (CPUT, Zero)
                    Method (_Q80, 0, NotSerialized)
                    {
                        If (ECOK)
                        {
                            Acquire (MUT1, 0xFFFF)
                            Store (CTMP, Local0)
                            Release (MUT1)
                        }

You just need to call right methods...

Maybe you can have at least some temp with:

acpi -V command...

Regards
Rudolf
