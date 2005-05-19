From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: libsensors version
Message-Id: <3FDB6C83.FAB11EC2@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213190847.GC1976@sirius.home>
In-Reply-To: <20031213190847.GC1976@sirius.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sorry.
just trying to play it safe after getting yelled at last time for
*not* changing the major number.
I'll copy your guidelines into our Makefile so we'll remember next time.

Sergey Vlasov wrote:
> 
> Hello!
> 
> Between lm_sensors 2.8.1 and 2.8.2 the libsensors version was changed
> from 2.0.1 to 3.0.0 - so the library soname was changed, indicating an
> incompatibility and forcing recompilation of all library clients.
> However, I don't see a reason for such change.
> 
> The library soname must be changed if and only if the interface is
> changed in a backward incompatible way.  The interface is defined by
> the public header files - in this case they are error.h, sensors.h,
> chips.h.
> 
> Changes in the public header files between 2.8.1 and 2.8.2:
> 
>   - error.h: was not changed at all.
> 
>   - sensors.h: only a comment was changed.
> 
>   - chips.h: here some new identifiers were added, but none of the
>     existing identifiers were changed or deleted, so older programs
>     would still work without recompilation.
> 
> There were binary-incompatible changes in data.h, but this is an
> internal header file (it is not even installed by "make install"),
> therefore such changes should not cause soname change.
> 
> Now it is too late, but I hope there will be no more unneeded soname
> changes in the future...
> 
> Best regards,
> Sergey Vlasov
> 
> 
>    Part 1.2Type: application/pgp-signature
