From: "Gustavo De Nardin (spuk)" <gustavodn@gmail.com>
Date: Tue, 15 Nov 2011 15:23:53 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE
Message-Id: <20111115152353.GA12423@zim>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
In-Reply-To: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Luca Tettamanti <kronos.it@gmail.com> [2011-11-15 10:52 +0100]:
> On Mon, Nov 14, 2011 at 10:45 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon, 14 Nov 2011 19:14:16 -0200, Gustavo De Nardin (spuk) wrote:
> >
> >> But the sensors values read with 'it87 force_id=0x8721' don't seem ok, I get
> >> this (first 'it87 force_id=0x8721', then 'asus_atk0110 new_if=1', which
> >> seems to provide good readings):
> 
> Please send me the output of "dmidecode -t 2" so I can override the
> default detection logic... this will allow the driver (atk0110) to
> work out of the box on your board.

Here it is:
-------8<----------8<----------
# dmidecode 2.11
SMBIOS 2.5 present.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: ASUSTeK Computer INC.
        Product Name: M5A78L-M/USB3
        Version: Rev X.0x
        Serial Number: 110203870000896
        Asset Tag: To Be Filled By O.E.M.
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis: To Be Filled By O.E.M.
        Chassis Handle: 0x0003
        Type: Motherboard
        Contained Object Handles: 0
-------8<----------8<----------

Thanks.

-- 
::question = (bool) _2b||!_2b;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
