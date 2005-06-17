From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Jun 2005 09:56:27 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <RY1xvwY3.1118994353.8411050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hugo,

On 2005-06-1, Hugo Vanwoerkom wrote:
> I obviously owe you one. If I can be of help anytime,
> give a holler.

Once we have a datasheet for that chip, we'll need a tester. We'll let
you know :)

> Output of sensors is below. Looks right, might need be
> tweaked. Temp1 23 degrees? The room temp here is 29
> degrees.

Yup, doesn't look too bad except for a few values (+3.3V, temp1... +12V
seems not to exist). We'll have to wait for a datasheet before we can
adapt the code though.

> Thanks again!

You're welcome.

--
Jean Delvare
