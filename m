From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: lm_sensors2/kernel/chips lm78.c
Message-Id: <3F47D460.5050402@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

FYI,
since other drivers don't do this, it is good practice to have the fan_div statments
before the fan_min statements in sensors.conf.

author@mordac.netroedge.com wrote:
> Update of /home/cvs/lm_sensors2/kernel/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv20601/kernel/chips
> 
> Modified Files:
> 	lm78.c 
> Log Message:
> (mmh) When changing fan divisor(s), save and restore fan minimum(s).
> 
