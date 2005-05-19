From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: suggestions for sensors.conf
Message-Id: <20020406224426.294313cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi folks.

Two suggestions for sensors.conf:

1* Don't use the tab char in the header, it will look ugly if tab space
isn't set to 8 (which is the case for me).

2* I think that this file should contain the lm_sensors versions it
comes from in its header.

-- 
Jean "Khali" Delvare
mail: khali@linux-fr.org
http://www.ensicaen.ismra.fr/~delvare/
