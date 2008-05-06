From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 15:49:03 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro PDSMi+
Message-Id: <20080506174903.6bc4fe4e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <482051E8.605@caps-entreprise.com>
In-Reply-To: <482051E8.605@caps-entreprise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 06 May 2008 17:41:16 +0200, Romain Dolbeau wrote:
> Jean Delvare wrote:
> 
> > This is with file V.131 (10/06/06) - if you have a newer one, can you
> > please send it to me in private? Thanks.
> 
> <ftp://ftp.supermicro.com/utility/Supero_Doctor_II/Linux/Beta/SD2_2.38.193_080425.tar.gz>
> 
> includes a version V.193 (04/23/08), which I used to check my values (I
> post this to the ML so that it can be useful to other hackers).

OK... there's this in the changelog:

;; 10/21/06: Change PDSMI+ Fan6 setting because Hardware Change

That explains the difference.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
