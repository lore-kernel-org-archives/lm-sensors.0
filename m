From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Oct 2013 10:07:29 +0000
Subject: Re: [lm-sensors] [PATCH] i2c-tools / man pages for decode-dimms & decode-vaio
Message-Id: <20131005120729.2344bc82@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120578650.1319664.1380881720059.JavaMail.root@redhat.com>
In-Reply-To: <1120578650.1319664.1380881720059.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jaromir,

On Fri, 4 Oct 2013 06:15:20 -0400 (EDT), Jaromir Capik wrote:
> The attached patch introduces man pages for
> the decode-dimms and the decode-vaio tool.

Thanks for your contribution.

> Please, check, modify if needed and merge.

Applied [1], with the following changes:
* Added the new option --no-merge-cells to decode-dimms.1
* Removed e-mail addresses, they quickly become out-of-date and
  contacting the original code author is generally not the right thing
  to do for a end user.
* Simplified Makefile integration. If manual pages are ever written for
  ddcmon and decode-edid, the code can be simplified even further.

[1] http://www.lm-sensors.org/changeset/6200

Thanks again,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
