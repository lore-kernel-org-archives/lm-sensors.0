From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: i2c-isa
Message-Id: <20030630152848.4ab31fc4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33f09$69546520$f265a8c0@gf01>
In-Reply-To: <000801c33f09$69546520$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi, sorry for my questions but, i compiled and installed i2c-2.7.0 and
> dont install i2c-isa.o....
> 
> Thx

It most probably has. Run "depmod -ae" (as root) to update your module
dependencies, and your system will see the file again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
