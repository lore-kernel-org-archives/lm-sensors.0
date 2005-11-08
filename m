From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Nov 2005 20:13:29 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <0Uv3p8AP.1131476435.3170330.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Paul,

On 2005-11-08, Paul Aviles wrote:
> # i2cdump 0 0x2e b
> (...)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: c7 74 c5 c4 00 29 23 25 a1 02 6e 03 a0 02 00 00    ?t??.)#%??n???..
> 30: 40 40 40 64 64 64 00 00 00 00 00 00 00 27 41 6a    @@@ddd.......'Aj
> 40: 05 80 01 d3 be d2 6b 82 b6 ca b6 ca 00 ff 05 44    ??????k?????..?D

This confirms that this is an ADT7463. The detection code is already
fixed in later versions of the driver. In the meantime you may want to
add the following line to /etc/modprobe.conf:

options lm85 force_adt7463=0,0x2e

One mystery remains. The VRM detection code said your CPU used VRM 9.1,
while the chip is configured in VRM 10 mode. What's your CPU? Please
paste /proc/cpuinfo. Maybe your CPU is too recent and was not yet
supported by our code in 2.6.9.

Thanks,
--
Jean Delvare
