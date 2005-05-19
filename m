From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: libsensors version
Message-Id: <20031213190847.GC1976@sirius.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

Between lm_sensors 2.8.1 and 2.8.2 the libsensors version was changed
from 2.0.1 to 3.0.0 - so the library soname was changed, indicating an
incompatibility and forcing recompilation of all library clients.
However, I don't see a reason for such change.

The library soname must be changed if and only if the interface is
changed in a backward incompatible way.  The interface is defined by
the public header files - in this case they are error.h, sensors.h,
chips.h.

Changes in the public header files between 2.8.1 and 2.8.2:

  - error.h: was not changed at all.

  - sensors.h: only a comment was changed.

  - chips.h: here some new identifiers were added, but none of the
    existing identifiers were changed or deleted, so older programs
    would still work without recompilation.

There were binary-incompatible changes in data.h, but this is an
internal header file (it is not even installed by "make install"),
therefore such changes should not cause soname change.

Now it is too late, but I hope there will be no more unneeded soname
changes in the future...

Best regards,
Sergey Vlasov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031213/2f9f9971/attachment.bin
