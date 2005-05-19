From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: lm_sensors2/lib chips.c
Message-Id: <20040214115736.0d4b270a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040121200144.7379410a.khali@linux-fr.org>
In-Reply-To: <20040121200144.7379410a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	chips.c 
> Log Message:
> (Khali) Fix vt1211 and vt8231 uch_config not being writable.

Note that support for lm80 in Linux 2.6, which was waiting in my local
repository, accidentally came with that commit. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
