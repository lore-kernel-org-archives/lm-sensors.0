From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <20031121234737.6bcbd627.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I don't know what it is, but this is no LM80 for sure. We
> would need to enhance our detection routine so that doesn't fall in
> that kind of trap.

I just commited such a change to sensors-detect in CVS. Could you please
check it out and give it a try (after unloading all chip drivers, of
course)? If shouldn't detect a LM80 anymore.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
