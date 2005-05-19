From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Should sensors-detect be merged with Hotplug or Discover
Message-Id: <20040508145440.2f34d278.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405081001.31499.david.goodenough@btconnect.com>
In-Reply-To: <200405081001.31499.david.goodenough@btconnect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I realise that some sensors are difficult to detect, but in the cases
> where detection is very reliable should not sensors-detect be merged
> into Hotplug or Discover (probably Discover as I am not aware of
> sensors which come and go, although with the hotpluging of memory
> modules which themselves might have sensors built in this may arrive)
> so that it all happens automatically without a separate sensors-detect
> stage?

I didn't know Discover. Looks like an interesting project.

However, as you mentioned, detecting sensor devices is hard and
sometimes highly unreliable. There are no standard identifiers such as
for other busses (PCI etc...). This will make things harder.

In any case, sensors-detect as it exists today is half-broken. The
script started its life 5 years ago, at a time where something like half
a dozen bus drivers and 4 or 5 chip drivers existed. It's architecture
isn't adapted to the high number of chips it now knows of. So if someone
is to add support for sensors to Discover, I'd recommend not using
sensors-detect as a starting point.

If someone wants to give it a try, why not. If the Discover folks need
assistance in doing it, we'll help. But I don't feel an immediate need
and this is too much work for me at the moment. There are higher
priority points to be worked on before.

-- 
Jean Delvare
http://khali.linux-fr.org/
