From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 30 Oct 2007 02:52:25 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710291952obc87637ye01e692946773ed9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On 10/29/07, Rudolf Marek <r.marek@assembler.cz> wrote:
> > It depends what methods are called. Imho if you remove the "thermal" support
> > from the ACPI it should be ok. If someone gives me the table, I can take a look.
>
> Also standard ACPI fan support driver should not be loaded.

Just got my hands on a W8000 machine yesterday. The Compaq Evo W8000
is blacklisted in the kernel and acpi=ht (hyperthreading only) is
forced during boot. So ACPI is pretty much disabled by default.

...juerg



> Rudolf
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
