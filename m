From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <1075716395.401e212b1493a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please CC: the mailing-list on reply.]

Quoting myself:

> We usually ignore read errors in chip drivers because they are rare,
> but since it happens so frequently with that specific chip, we will
> have to do it here. I will try to implement the solutions listed
> above, if you want to help me test them.

Here is a patch, tested to apply and compile on Linux 2.6.2-rc3. Could
you please give it a try? It should solve the rare "-1" readings
problem, as well as possible misdetection issues.

If the driver is really unable to read a register value, it will
silently return the previously known value (or 0 if it doesn't have one
yet). Maybe we could log the incident, although I'm fairly certain it
will never happen, providing the number of max retries is high enough
(I set it to 5 for now).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.2-rc3-i2c-w83l785ts-retries.diff
Type: application/octet-stream
Size: 3342 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040202/ca50f495/linux-2.6.2-rc3-i2c-w83l785ts-retries.obj
