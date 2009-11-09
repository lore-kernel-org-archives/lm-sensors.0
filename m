From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Nov 2009 12:53:48 +0000
Subject: Re: [lm-sensors] lm sensors help
Message-Id: <20091109135348.348a2670@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <EDE287309C3D8141BC2A1DB7D9F8925D01C2D683EC@ESGSCCMS0002.eapac.ericsson.se>
In-Reply-To: <EDE287309C3D8141BC2A1DB7D9F8925D01C2D683EC@ESGSCCMS0002.eapac.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rim,

On Mon, 9 Nov 2009 16:50:27 +0800, Rim Shao wrote:
> Thanks for your value information.
> I am using the SLES10(SUSE Linux Enterprise Server By Novell) SP 2, the runing kernel is 2.6.16.60-0.21-smp.

OK, SLES10 SP2 is a reasonable OS to use :)

> After I use the latest sensors-detect and the output is pasted below. I got that my chip is 'IPMI BMC KCS'.
> 
> 
> =========
> # ./sensors-detect
> # sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
> # System: Hewlett-Packard ProLiant DL380 G6

Hmm. Your original report was for an "HP workstation FF825AV". Now you
run sensors-detect on a DL380 G6 server. Please clarify which system
you are willing to run lm-sensors on. Mixing requests really doesn't
help us help you. I will comment the output below anyway...

> (...)
> Sorry, no supported PCI bus adapters found.

No SMBus on this system? That would be surprising. Please provide the
output of lspci.

> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `to-be-written':
>   * ISA bus, address 0x300 (Busdriver `i2c-isa')
>     Chip `SMSC SCH4307 Super IO Fan Sensors' (confidence: 9)

We do not have a driver for this chip. There's a note on our wiki that
we have a datasheet, but I don't and I can't find it on SMSC's website.
I'm not totally certain if we can add support for this chip. If we do,
this will be low priority as this is a rare chip (first request) unless
you can donate some hardware to the project.

Juerg, this note on the wiki might be from you?

Note that this chip only supports fan speed monitoring according to my
notes, this isn't a full-featured monitoring chip. It is frequent that
the fan monitoring feature isn't used in that case, so this would need
to be verified before writing a driver. We would also have to
double-check that ACPI doesn't make use of it.

> Driver `coretemp':
>   * Chip `Intel Core family thermal sensor' (confidence: 9)

Support for these CPU sensors was added in kernel 2.6.22, so not
available in SLES10. If Ericsson want support backported to the SLES10
SP3 (or maybe even SP4) kernel, please send a formal support request to
Novell. If they accept, I'll be happy to help.

> Driver `ipmisensors':
>   * ISA bus, address 0xca2 (Busdriver `i2c-isa')
>     Chip `IPMI BMC KCS' (confidence: 8)

sensors-detect is a little misleading there, as support for IPMI
sensors was never really added. It has been work in progress for years.
Your best chance here is to install and use ipmitool. You may or may
not be able to retrieve hardware monitoring information, depending on
the BMC connected.

Hope that helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
