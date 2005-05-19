From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: lm_sensors2 Makefile
Message-Id: <20030616190401.5bacf6ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1033131073.3d945441d6d95@imp.free.fr>
In-Reply-To: <1033131073.3d945441d6d95@imp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Modified Files:
> 	Makefile 
> Log Message:
> (Khali) Make -Wall mandatory. Add -W to optional warnings.

This will generate much noise, which proves (IMHO) that this was
necessary.

I will take care of cleaning all trivial warnings. The ones that will be
left will belong to the related code's authors ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
