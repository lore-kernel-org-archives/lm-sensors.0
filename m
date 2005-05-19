From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <20040924200503.652ccf8e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org>
	<20040921154111.GA13028@kroah.com>
	<41545421.5080408@web.de>
In-Reply-To: <41545421.5080408@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold-ml@web.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

> We like to have an completly isolated i2c adapter, where the device 
> driver can invite i2c drivers to connect an i2c client to. When the 
> connection is made, an "interface" pointer with client-specific data
> or function pointers can be provided.
> (...)
> - add a new NO_PROBE flag to struct i2c_adapter, so a particular
> adapter is never probed by anyone

I don't get it. If the adapter is isolated, there is no way the i2c-core
will probe it anyway. As Adrian Cox underlined, it should be far easier
and more efficient to separate these adapters from the main i2c adapters
list from the beginning than leaving them in the main list and then try
and prevent future probings using a flag.

Also, how does this proposal interact with the work on the i2c classes?
Although the classes carry more information than a simple flag or a
complete separation, both were/may be introduced to achieve the same
goal, isn't it?

Thanks,

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
