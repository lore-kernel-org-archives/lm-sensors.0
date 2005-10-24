From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 24 Oct 2005 16:39:44 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] i2c: Fix incorrect ID uses
Message-Id: <S2WHduaW.1130164030.4462810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051022154830.0b7688ab.khali@linux-fr.org>
In-Reply-To: <20051022154830.0b7688ab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-10-24, Mark McClelland wrote:
> Thanks for cleaning this up!
>
> BTW, someone might want to take a look at include/media/id.h. It could
> stand to be cleaned up or deleted altogether:

You're right. I'll do a second patch for these ones, thanks for
pointing this out. Deleting the file sounds sane, it makes no sense to
have such a file in-tree.

--
Jean Delvare
