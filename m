From: Juerg Haefliger <juergh@gmail.com>
Date: Fri, 09 Apr 2010 15:28:38 +0000
Subject: Re: [lm-sensors] No readings except for core temperatures on Dell
Message-Id: <u2m191fb4ca1004090828r137e72dene6cdbcbae68f7492@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270818360.2014.8.camel@tobias-fgis>
In-Reply-To: <1270818360.2014.8.camel@tobias-fgis>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Tobias,

<SNIP>

>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x8d01

I don't know what this device is. It might be Dell specific. Can you
open the machine and try to read the part name? Must be something like
SMSC ...

...juerg



> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
