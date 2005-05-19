From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: pwmconfig fix
Message-Id: <20040508213903.16456e10.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Latest version of lm_sensors2? I did a fresh checkout of lm_sensors2
> which didn't solve anything (cvs -d
> :pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout lm_sensors2).

Hm, that's bad :(

That said, I just realized that I fixed only pwmconfig, while fancontrol
needed a change too. Just changed that. And I had missed some changes in
pwmconfig as well. I should really have been more careful, sorry.

Care to test again? It should be better.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
