From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: get CVS ?
Message-Id: <200405191431.i4JEV2lk074244@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040519141143.GA20145@cereve.enpc.fr>
In-Reply-To: <20040519141143.GA20145@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I have linux 2.6.6 and I would like to install lm_sensors CVS version
>because of vid pb with 2.8.6 version
>
>is there an "easy" way to retrieve the CVS version
>as a gzipped tar file ?

No, you have to access the CVS server yourself.

>on the web site it is adviced to use CVS i2c with the CVS lm_sensors, but
>I have already heard that all i2c stuff was already included in 2.6.x
>kernels, so what to do ? do I have to patch the kernel ?

No, you're right. You don't need i2c, and you don't need to patch your
kernel either. Just checkout the lm_sensors2 repository, compile it with
"make user" and install it with "make user_install". There are no
differences with installing, say, lm_sensors-2.8.6.
