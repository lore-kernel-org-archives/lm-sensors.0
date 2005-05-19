From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: lm_sensors2/kernel/chips w83792d.c
Message-Id: <eYFOCBui.1112168417.7962950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050329011601.GA14733@jupiter.solarsys.private>
In-Reply-To: <20050329011601.GA14733@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> When the fan divisor adjust itself automatically step by step, Should
> the fan limit keep the original value?

Yes it should. It is already prefered when changing the divider is a
manual operation. It becomes a requirement when the divider changes
automatically.

> It seems that in your driver, the fan limit value will also change with
> the fan divisor like mine?

No, the fan min value, expressed in RPM, is preserved.

> Could you tell me the exact purpose of "old_min"?

It's there to prevent writing the new register value if it happens to be
the same as before (which will basically happen if the divider was not
changed - I guess I could have tested the divider value instead for a
similar result.

--
Jean Delvare
