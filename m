From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: i2c-pport cleanups
Message-Id: <200407130940.i6D9evQf057079@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

Can you please test the attached version of i2c-pport (for 2.4). It
implements all the cleanups and fixes we discussed yesterday.

Note that:
* The tests are compeletly gone in bit_pport_init. i2c-algo-bit already
has this functionality (test_bit=1 IIRC).
* I also fixed a case where IO address wouldn't be released (if
i2c_bit_add_bus fails in i2c_bitpport_init).

Additional cleanups may be done later:
* Merge i2c_bitpport_init and bit_pport_init. They really belong to the
same function.
* Have base and PortData belong to a structure that would be pointed to
by bit_pport_data.data. That would be way cleaner than having base faked
as a pointer value and PortData global. This also opens a path to how we
can integrate this cleanly in 2.6's i2c-parport.

Thanks,
Jean Delvare
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-pport.c
Type: application/octet-stream
Size: 4578 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040713/525620de/i2c-pport.obj
