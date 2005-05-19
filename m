From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Constant beep and ALARM warnings on ALI1535
Message-Id: <20040202204706.1a5a5af7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401311948.50570.juanpedro@fibertel.com.ar>
In-Reply-To: <200401311948.50570.juanpedro@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Ok, the people from ALI sent me one of those, it's the pdf attached.

Unfortunately it doesn't seem to contain any information about a
hardware monitoring component :( I was hoping it would, but can't find
anything of value (for us) in the data sheet.

If you had a first contact with ALi, your best chance is to explain to
them the situation you're in, with the details, and ask them for details
about the hardware monitoring component included in the M1647, if there
is one. Basically, if the hardware monitoring chip is really from them
and if they can provide a data sheet, then there's a possibility to
write a driver. If not, we're mostly doomed :/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
