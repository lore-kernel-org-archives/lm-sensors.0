From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lm_sensors2/lib data.c init.c
Message-Id: <20031124212556.1deac3be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	data.c init.c 
> Log Message:
> (Khali) Fix memory leak.

There still are three of them in the library, but it's in the generated
parser code. I just can't read this, so I will be unable to fix them. If
anyone with more knowledge of bison/flex could tackle this, I'd of
course help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
