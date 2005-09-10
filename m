From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 10 Sep 2005 22:56:12 +0000
Subject: [lm-sensors] 2006b3 ksensors cpu temp pb
Message-Id: <20050910225604.57cb1a1f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509091803.30808.philippe.roubach@free.fr>
In-Reply-To: <200509091803.30808.philippe.roubach@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Philippe,

> For the sensors asb100/CPU Temp(AMD) 
> Ksensors indicates a steady value around 48 ?C. 
> Temperature never changes ! 
> 
> This pb occurs since Mdv LE 2005. 
> It was working well under Mdl 9.2 
> 
> Under 9.2 there were only CPU temp sensor 
> Since LE 2005 there is CPU temp(Intel) and CPU temp(AMD). 
> Perhaps pb comes from here. 

There are four temperature inputs on the ASB100 chip. If one doesn't
provide interesting values, maybe the others will.

Anyway, you are not providing any information that is useful for us to
help you. If the problem is in ksensors, please report it to the author
of this program. If the problem seems to be Mandriva-specific, report it
to the Mandriva support.

If you think the problem is with lm_sensors itself, then please provide
all the relevant information: lm_sensors version, kernel version, output
of "sensors", asb100-* section of your /etc/sensors.conf file.

-- 
Jean Delvare
