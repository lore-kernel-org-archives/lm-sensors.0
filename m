From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 08 May 2008 23:34:43 +0000
Subject: Re: [lm-sensors] [PATCH v3] ibmaem: New driver for
Message-Id: <20080508163443.a1e9ffe7.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508180858.GM16078@tree.beaverton.ibm.com>
In-Reply-To: <20080508180858.GM16078@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 8 May 2008 11:08:59 -0700
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> This driver reads IBM Active Energy Manager energy/temperature/power
> sensors on IBM System X hardware.

This driver is littered with 64-bit divides and doesn't link on i386.
I'll make it depend on CONFIG_64BIT for now.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
