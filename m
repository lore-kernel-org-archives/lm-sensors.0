From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Wed, 26 Oct 2005 00:43:06 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <200510260042.09259.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> I will add some more information to the archive. It seems it is ICH4
> compatible because it reserves for ACPI the 16 bytes. So HW PEC should be
> supported too.
>
> Pavel could you please dump with isadump:

Here is requested isadump:
-----------------------------------
[root@home ~]# isadump -f 0x400 16
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x400 to 0x40f.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 37 ae 3c 00 00 00 00 00 00 00 00 a0 00
-----------------------------------

> Regards
> Rudolf

Best regards,

Pavel Ruzicka
