From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <20040701200551.162a11fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> has one LM79 and two LM75s.  Here they are:
> 
> [root@earth root]# i2cdump 0 0x4c

Care to dump in word mode? Most registers are 16-bit on this chip.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
