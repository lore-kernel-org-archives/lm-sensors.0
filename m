From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix debug bug in lm83 driver
Message-Id: <20040114212153.5503d1fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111175123.54cdeb9f.khali@linux-fr.org>
In-Reply-To: <20040111175123.54cdeb9f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Add #define DEBUG at the start of the file, no vodo magic needed :)

Hm. I wonder if I should really tell you what I did. I'll be ridiculous.
Hm.

Anyway... My "#define DEBUG" was after all other includes. So dev_dbg
was resolved to nothing. Because the call to dev_dbg was after my
#define, I expected it to resolve correctly...

Shame on me, and thanks for the explanation.

Still doesn't explain why adding -DDEBUG to the main Makefile didn't
do the trick, but I don't have that much time to waste to investigate it
all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
