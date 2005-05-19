From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Lmsensor support in Unix ? (fwd)
Message-Id: <20030522185929.61003a44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200305221607.h4MG7hrX001468@shire.frodo.local>
In-Reply-To: <200305221607.h4MG7hrX001468@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>       I am successful user in making the lmsensor to work in my server
>       with Linux. But now in recent days we have to change the server
>       OS to the SCO UnixWare 7.1.3 . Is there any way I can port
>       lm_sensors to Unix also ? 

I think it would be technically very difficult (because most of the code
is really tied to the Linux kernel) and maybe not even legal (because
our code is GPL and SCO's isn't). Not too sure about this though.

What I am sure of is that you should beware of SCO. Their policy is
really uncertain these days. After supporting Linux for a while, they
are now suing IBM and others for some obscure reasons (I say obscure
because I don't fully understand what they can expect to get, except
being hated by thousands of people around the world, help their real
opponent and hurt their allies).

See there, they explain themselves:
http://www.sco.com/scosource/letter_to_linux_customers.html


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
