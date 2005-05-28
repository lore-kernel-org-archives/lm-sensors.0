From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 28 May 2005 11:38:33 +0000
Subject: [lm-sensors] PATCH libsensors: ds1780 fix
Message-Id: <20050528113842.6f51b819.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
In-Reply-To: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> This patch removes separate ds1780 defines and links them instead 
> to adm9240 as is done for LM81 register compatible.  Compile tested

Looks sane, applied, thanks. You forgot to remove all the defines in
chips.h, I did it. I also edited the comments, the library really
doesn't care that the chips are register compatible. What matters here
is that the chips expose the same feature set.

-- 
Jean Delvare
