From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 16 May 2006 07:17:27 +0000
Subject: [lm-sensors] [lm-sensors-commit] lm_sensors2/lib conf-lex.l
Message-Id: <20060516091727.492d4e62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/lib
> In directory mordac.netroedge.com:/tmp/cvs-serv21915/lib
> 
> Modified Files:
> 	conf-lex.l 
> Log Message:
> (mmh) Allow the config file scanner to release its buffers upon EOF.

Wow, excellent work Mark, once again!

It now looks to me like libsensors has no more memory leaks left? This
is really great news :)

-- 
Jean Delvare

