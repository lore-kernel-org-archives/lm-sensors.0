From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 16:00:33 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro PDSMi+
Message-Id: <20080506180033.54f9679c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <482051E8.605@caps-entreprise.com>
In-Reply-To: <482051E8.605@caps-entreprise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 6 May 2008 17:49:03 +0200, Jean Delvare wrote:
> OK... there's this in the changelog:
> 
> ;; 10/21/06: Change PDSMI+ Fan6 setting because Hardware Change
> 
> That explains the difference.

Also of interest is:

;; 01/08/07: Change System Temperature to Offset! for PDSMU, PDSM4+, PDSMA+, PDSML+, PDSMI+, PDSMI-LN4+

Which changes the System temperature from temp5 to temp6. This matches
the fact that a BIOS update enabled temp6 on that board.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
