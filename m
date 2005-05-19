From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: it87 and lm85 tickets
Message-Id: <20050328184238.2fc0f0e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374305.6030000@mds.gotdns.com>
In-Reply-To: <42374305.6030000@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> So, most likely this is a later version of the lm96000.

My conclusion exactly.

> You might check again.  But instead of looking for a chip with
> "LM85", look for a 24-pin surface mount package with "LM96???" on
> it.  It will be smaller than the keys on your keyboard, but larger
> than the tip of a  pen or pencil.

Intel has some docs:
ftp://download.intel.com/design/motherbd/cv/C6859702.pdf

Page 38 there is a drawing, the LM9600 would be "C", i.e. between CPU
and memory slots.

-- 
Jean Delvare
