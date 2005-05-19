From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030611103328.51e9fab9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Modified Files:
> 	sensors-detect 
> Log Message:
> (Khali) Undid outb() fix by Jim Morris.
>         Fixed faulty outb() calls.
>         Armored outb() against future faulty calls.

Please note that I in no way pretend the issue is solved. It is just my
first step in trying to solve it.

Jim, could you please checkout the new sensors-detect and give it a try?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
