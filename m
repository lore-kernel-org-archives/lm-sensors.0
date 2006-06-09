From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 09 Jun 2006 19:00:12 +0000
Subject: [lm-sensors] [PATCH] New VID codes for Intel Core and Conroe
Message-Id: <4489C53C.2010702@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <447815E5.5060601@sh.cvut.cz>
In-Reply-To: <447815E5.5060601@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> It includes an "Extended VRD 10.0" VID table. I seem to understand that
> the CPUs may alternatively use this table or the VRD 11.0 table you
> added support for. I don't really understand what would make a CPU use
> one rather than the other though. Can you please investigate? Then your
> patch might need some more work. At least it would be nice to point to
> the official location for the VRD 11.0 table.
> 

Ok I have investigated. It took me one hour to figure it all out.

the VID_SELECT pin is for motherboard that has LGA775 and wants to support old
and new CPUs. Intel introduced the bit already for older Celeron D
http://www.intel.com/design/celeron/datashts/304092.htm

Page 69 clarifies it all.

They already reserved enough bits for VID, using just 5 of them.

With the VID_SEL bit they will just do what we do in software to detect the VRM
version. So => we dont care about this bit.

As for the Extended VRD 10.0:

it just adds one more bit do be able to fine grain the 5bit VID. And because my
patch already rounds it we should not care about this too.

All in all we dont need to do anything special unless we switch to uV as return
value.

I will resend the patch in the moment with updated VRM11 stuff.

Regards
Rudolf

