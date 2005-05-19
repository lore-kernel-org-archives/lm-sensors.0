From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030605112327.325ec925.khali@linux-fr.org>
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
> (Khali) Added nForce2 detection, which was missing, although we have
>         nForce2 supported since 16 Feb 2003.

Note that I do not have a nForce2 at hand, so this is untested. I don't
know exactly what I was supposed to fill in the procid and match fields,
I hope it'll work as expected.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
