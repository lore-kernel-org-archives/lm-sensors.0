From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Not Support Chip
Message-Id: <3DE65069.F8681A1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021128092949.GA4637@bbnslab>
In-Reply-To: <20021128092949.GA4637@bbnslab>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

please send us the output of 'lspci -n'

Yun-Ta Tsai wrote:
> 
> sensor-detect output---
> BIOS vendor (ACPI): ASUS
> System vendor (DMI): System Manufacturer
> BIOS version (DMI): ASUS P4B533-E ACPI BIOS Revision 1004
> We can start with probing for (PCI) I2C or SMBus adapters.
> You do not need any special privileges for this.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.
> 
> We will now try to load each adapter module in turn.
> end of output---
> 
> Chipset(from motherboard manual):
>         Intel 82845E MCH
>         Intel 82801 DB ICH4
> 
> Thanks
> 
> Best Regards
> 
> Tim
> 
> 
>                      Name: default.txt
>    default.txt       Type: Plain Text (text/plain)
>                  Encoding: quoted-printable
>               Description: PGP =?big5?B?xl+wzSAweDM4REQ3OUVDoUM=?
