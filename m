From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Nov 2009 12:39:16 +0000
Subject: Re: [lm-sensors] Found unknown chip with ID 0x8700
Message-Id: <20091124133916.2fe60478@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <8d7042a0d09388fda56b06824479d5ab.squirrel@webmail.timeweb.ru>
In-Reply-To: <8d7042a0d09388fda56b06824479d5ab.squirrel@webmail.timeweb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

On Tue, 24 Nov 2009 15:27:02 +0300, daniel.solgalov@medicalmart.ru wrote:
> Hi!
> I am using opensuse 11.2 with factory kernel-desktop 2.6.32 with my MSI
> WIND U210 netbook.
> There is no fan control under Opensuse so i guess it is because of the
> following sensors-detect output ("Found unknown chip with ID 0x8700"):
> 
> sensors-detect
> # sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
> # System: Micro-Star International U210 (laptop)
> # Board: MSI MS-1241
> (...)
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   Yes
> Found unknown chip with ID 0x8700
> (...)
> I guess it is ITE IT8700 chip which is likely to be the same as IT8705?

Certainly not. The IT87xxF chips are made by ITE, while sensors-detect
found a National Semiconductor super-I/O chip on your board.

Your best chance at this point is search for technical documentation
about your netbook and see if they say which super-I/O (or LPC) chip is
used. That being said, I wouldn't hold my breath: most laptops/netbooks
have minimalist super-I/O chips with little to no hardware monitoring
features anyway.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
