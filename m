From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [patch] i2c-piix: Don't treat ServerWorks servers as Laptops
Message-Id: <20040530112130.2c82d836.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040529142325.GA14964@ucw.cz>
In-Reply-To: <20040529142325.GA14964@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm sending you this little obvious patch which should enable i2c-piix
> to work on IBM servers with ServerWorks chipsets. It still will treat
> any IBM/Intel machine as a laptop and refuse to work, but it's better
> than before.

Fine with me. Note that the whole thing will hopefully disappear soon in
2.6 anyway. OTOH a similar "fix" would be welcome for 2.4 since I don't
plan to to the big change there.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
