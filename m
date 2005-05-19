From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors2/kernel/include sensors_vid.h
Message-Id: <20040915204604.26ac5be7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	sensors_vid.h 
> Log Message:
> (mmh) bugfix: small tweak to VID calculation for VRM v10.0

Nice catching. BTW, the Linux 2.6 version of the file lacks VRM 10.0
support (as well as Opteron support, for that matter). Anyone cares to
send a patch to Greg?

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
