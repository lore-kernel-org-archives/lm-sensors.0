From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 10 Jan 2009 10:30:01 +0000
Subject: Re: [lm-sensors] Aspire One Intel Atom's Motherboard support
Message-Id: <20090110113001.4dc73f32@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f4897e880807160553h3d8dacdfy20efdddfc8c4b476@mail.gmail.com>
In-Reply-To: <f4897e880807160553h3d8dacdfy20efdddfc8c4b476@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 10 Jan 2009 11:01:36 +0100, Dieter Jurzitza wrote:
> Dear listmembers,
> please see contents of the file "out" attached - this stems from my Acer 
> Aspire One.
> Thank you for looking into this,

Nothing relevant on the SMBus, and unknown Super-I/O chip. I'd say
you're out of luck and there is no hardware monitoring chip on this
motherboard. That's rather frequent on laptops, usually thermal
management is taken care of by ACPI and that's it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
