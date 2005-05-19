From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Call for 2.8.2 soon
Message-Id: <20031125073618.74adc0a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Some of it really is "real bugfixes".
> Fixing the magnitudes in the w83781d temperatures
> is probably the most important...

There is no patch for this yet AFAIK. I took a look at the code, and I'm
not sure I understand how to fix it. The conversion macros are much too
complicated IMHO, and could probably be simplified. If anyone wants to
take a chance...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
