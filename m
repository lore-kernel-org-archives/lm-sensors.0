From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 16 Mar 2014 22:13:31 +0000
Subject: Re: [lm-sensors] hp dc7900
Message-Id: <5326220B.8000600@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <53220AB5.8010809@sojka.co>
In-Reply-To: <53220AB5.8010809@sojka.co>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

According to technical reference guide the SIO is responsible for temp 
monitoring and it is that WPCD376H chip. Also there is a mention of some BIOS 
call to get temp status (using real/prot mode call)

http://static.highspeedbackbone.net/pdf/HP%20Compaq%20dc7900%20Series%20Business%20PC%20Service%20Hardware%20Reference%20Guide.pdf

Possibly way would be to reverse engineer the call to see what is going on. But 
this is just a start of uncertain journey.

Thanks
Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
