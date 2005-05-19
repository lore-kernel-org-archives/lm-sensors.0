From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: Requested information: Ticket ID 1978
Message-Id: <20050508151119.4c7cce2c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1115297379.8633.4.camel@localhost>
In-Reply-To: <1115297379.8633.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Ticket ID: 1978
> 
> i2cdump 0 0x57
> (...)
> 80: 56 47 4e 2d 54 31 58 50 5f 4c 28 44 45 29 00 00   VGN-T1XP_L(DE)

Older VAIOs had prefix PCG, newer have prefix VGN. The "sensors" program
only knows about "PCG", so it misses your new model. I just added the
VGN prefix so the CVS version should now work.

-- 
Jean Delvare
