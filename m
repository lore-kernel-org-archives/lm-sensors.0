From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 03 Jun 2005 23:47:22 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <d120d5000506031446712cd9e8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> 6. I wrote reconnect feature: if on start there are no
> registered families all new devices will have defailt family,
> later when driver for appropriate family is loaded, slaves,
> which were faound earlier, will still have defult family instead
> of right one. Reconnect feature will force control thread to
> run through all master devices and all slaves found
> and search for slaves with default family id and try to reconnect
> them.

Yep, start with one kludge and you'll end up with 10 more.

Would you mind explaining why a w1 device has to be bound to a family
before it can show in sysfs? We don't have such limitation on other
buses, why is it needed for w1?

-- 
Dmitry
