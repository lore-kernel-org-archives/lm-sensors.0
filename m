From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 15 May 2006 07:14:15 +0000
Subject: [lm-sensors] [lm-sensors-commit] lm_sensors2/lib init.c
Message-Id: <20060515091415.f190a8fd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/lib
> In directory mordac.netroedge.com:/tmp/cvs-serv24577/lib
> 
> Modified Files:
> 	init.c 
> Log Message:
> (mmh) fix 2 leaks found by valgrind - missing some free() during cleanup
> (as opposed to ongoing run-time leaks)

Nice catch Mark!

-- 
Jean Delvare

