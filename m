From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH remove W83781D_RT ???
Message-Id: <20050327134550.1fb21c18.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
In-Reply-To: <hhec41h8ba5mi0ds5d1ong46amvgm7s3f7@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Driver w83781d: W83781D_RT appears to have a bug, one suggested 
> solution is to remove it if there are no users.
> 
> Anyone use it?  Need a second :)

As I said elsewhere, I am in favor of this removal. If there were any
used, we would have heard of that bug.

Just please redo the patch with the W83781D_RT definition removed as
well, and wait for the big lock patch to be sent to Greg before sending
this one, and make sure it apply fine on top of it.

Thanks,
-- 
Jean Delvare
