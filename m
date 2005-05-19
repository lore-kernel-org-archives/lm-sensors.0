From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030603094458.6eb6168c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/prog/detect
> In directory mordac.netroedge.com:/tmp/cvs-serv11020
> 
> Modified Files:
> 	sensors-detect 
> Log Message:
> (Khali) Now supports dmidecode 2.0 and later.

Notice that I didn't updated the included version of dmidecode. It is
still 1.8 and I plan to stick to 1.x. I simply made sure sensors-detect
would work with dmidecode 2.x so that people already having dmidecode on
their system (i.e., not from lm-sensors) have no trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
