From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 19:02:22 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060828210222.3af0ca23.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anthony,

> 	Apparently one of the updates has to do with the hwmon class,
> because not it does exist, with the adm1026 driver attached to it.  

I have access now and I can confirm that, the update adds the adm1026
and lm87 drivers, backported from a later kernel. It adds the hwmon
class as a side effect, because the later kernel had it so the adm1026
and lm87 driver used it.

-- 
Jean Delvare

