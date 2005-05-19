From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <20040221165017.50eda046.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have corrected this and attached the new patch to the mail.

I just commited a new fix to the w83627hf driver (CVS). Could you
incorporate it in your driver? (Sorry ;))

Also, please consider changing this:
+     If you say yes here you get support for the Winbond W836X series
to:
+     If you say yes here you get support for the Winbond W836X7 series

Not very important, I admit, but I think it designates the family better.

MMH, can you take care about this port (review, test if possible, and
send to Greg)?

Thanks (both of you).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
