From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 09:32:25 +0000
Subject: [lm-sensors] Abit uGuru
Message-Id: <428C40E1.9020700@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <428A38E8.2000801@icon.co.za>
In-Reply-To: <428A38E8.2000801@icon.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> How do I go about to help to include a partial implementation into
> lm_sensors (or alternatively is it more feasible to think of a GKrellM
> plugin)?

It can be imlemented as classical kernel module - hw monitoring module.

> I must confess that I miss the temperature readings on my PC because the
> current (windows) speedfan beta now understands uGuru.

We did not start developement ourselfs - we do not support undocumented chips.

> If required I can post the Olle Sandberg ollebull@gmail.com February
> 2005 source.

If you want you can, but no-one will write the driver. Maybe it would be good to keep his
code penamently somewhere in archive so it is not lost.

Our policy is not support undocumented chips. It simply brings a lot of troubles.
If you want support under linux go and complain to Abit or do not buy their products.
However if you get the official specs we will write most likely the driver.

If you want to write driver yourself and do all support about uGuru stuff you can.
We can't forbid you doing so. I know Olle did not write because he told me recently that he
does not feel lot skills in linux.

Regards

Rudolf
