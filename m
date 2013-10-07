From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 07 Oct 2013 22:18:58 +0000
Subject: Re: [lm-sensors] Sudden shutdown and wrong temperature reading (driver jc42)
Message-Id: <52533352.6060800@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
In-Reply-To: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/07/2013 02:27 PM, Olavo Luppi Silva wrote:
>
>
>
> 2013/10/3 Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
>
>     On 10/03/2013 03:41 PM, Olavo Luppi Silva wrote:
>
>
>
>
>         2013/9/27 Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net> <mailto:linux@roeck-us.net <mailto:linux@roeck-us.net>>>
>
>              On 09/27/2013 01:38 PM, Olavo Luppi Silva wrote:
>
>                  Hi Guenter,
>                  Thanks for replying.
>                  I didn't configure acpi_enforce_resources=lax in your boot command line. I just made the following steps to install lm-sensors:
>
>              Hi,
>
>              please don't top-post, and please don't drop the mailing list from your replies.
>
>
>         Hi Guenter, sorry for that.  I was not aware of replying style of this mailing list and I clicked 'reply' instead of "reply all".
>
>
>              you would not see an error, but something like
>
>              ACPI Warning: 0x000000000000f040-____0x000000000000f05f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20130517/utaddress-251)
>              ACPI: This conflict may cause random problems and system instability
>              ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
>
>         Unfortunately workstation Raphson died this week. It was running a long process using MKL and ATLAS math libraries and when I got in the office in the morning it was shutdown.  Push power button: nothing happens. Unplug and plug power cable: the fans work for a few seconds and then stop. I was taken to the technical assistance.
>
>              Let's assume you don't see that. Next question is if your system supports IPMI.
>              If it does, there is a slight chance that the IPMI controller accesses the SMBUs,
>              causing an access conflict.
>
>         IPMI is an Intelligent Platform Management Interface, right? How can I check if my sistem supports IPMI?   Our workstations are using Ubuntu and Kubuntu 12.04 LTS. I don't remember if I did install such interface.
>
>
>
>     You'll find that information in the board specification. The output from sensors-detect below
>     also shows you that the board supports IPMI.
>
>     Furthermore, the Intel server board specification states that IPMI monitors the temperature
>     and voltage sensors on the board. So if Raphson uses the same board, the most likely explanation
>     for your problem is that IPMI and the jc42 driver try to access the DIMM temperature sensors
>     at the same time. This would expmain both the read errors and the occassional resets (if IPMI
>     resets the board if it happens and it reads a bad/high temperature).
>
>     Guenter
>
>
> Thank you for your clarification, Guenter.
> Kalman and Gauss have the same motherboard that Raphson. I'll uninstall lm-sensors and use ipmitools to monitor temperature instead, as Jean Delvare pointed.
>
> Do you think that the conflict between IPMI and lm-sensors could also explain the last Raphson's failure? It worked for about one month at full load and suddenly shut down and never turned on again.
>

That is really quite unlikely.

Of course, it is theoretically possible that this could happen, for example
if there is a badly managed power controller chip involved. I don't think that
is the case here, though. After all, we are talking about access to temperature
sensor chips, not power controllers.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
