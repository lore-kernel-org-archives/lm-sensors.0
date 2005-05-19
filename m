From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: New patches of 2.8.0 against 2.4.22...
Message-Id: <20030913164632.378ba87b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F526E97.7010906@realitydiluted.com>
In-Reply-To: <3F526E97.7010906@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The stuff I did was due to linking errors associated with the SCx200
> drivers when compiling everything in statically and also header file
> dependency problems. I am happy with your suggestions as long as
> testing is done with both statically linking and as modules. I do
> not have any SCx200 devices, so I just guessed at the dependencies.

Same here. I do not have such devices, but wanted the dependencies
fixed. A careful look at the includes helped a lot finding the best
fixes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
